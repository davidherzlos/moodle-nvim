local action_state = require "telescope.actions.state"
local action_set = require "telescope.actions.set"
local actions = require "telescope.actions"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"

local M = {}

local function gen_from_buffer_lines(opts)
  local displayer = entry_display.create {
    separator = "",
    items = {
      { width = 4 },
      { remaining = false },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.lnum, "LineNr" },
      {
        entry.text,
        function()
          if not opts.line_highlights then
            return {}
          end

          local line_hl = opts.line_highlights[entry.lnum] or {}
          -- TODO: We could probably squash these together if the are the same...
          --        But I don't think that it's worth it at the moment.
          local result = {}

          for col, hl in pairs(line_hl) do
            table.insert(result, { { col, col + 1 }, hl })
          end

          return result
        end,
      },
    }
  end

  return function(entry)
    if opts.skip_empty_lines and string.match(entry.text, "^$") then
      return
    end

    return make_entry.set_default_entry_mt({
      ordinal = entry.text,
      display = make_display,
      filename = entry.filename,
      lnum = entry.lnum,
      text = entry.text,
    }, opts)
  end
end

local function buffer_jump(opts)

  opts = opts or {}
  opts.bufnr = opts.bufnr or 0

  -- All actions are on the current buffer
  local filename = vim.api.nvim_buf_get_name(opts.bufnr)
  local filetype = vim.api.nvim_buf_get_option(opts.bufnr, "filetype")

  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
  local lines_with_numbers = {}

  for lnum, line in ipairs(lines) do
    table.insert(lines_with_numbers, {
      lnum = lnum,
      bufnr = opts.bufnr,
      filename = filename,
      text = line,
    })
  end

  local ts_ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
  if ts_ok then
    filetype = ts_parsers.ft_to_lang(filetype)
  end
  local _, ts_configs = pcall(require, "nvim-treesitter.configs")

  local parser_ok, parser = pcall(vim.treesitter.get_parser, opts.bufnr, filetype)
  local get_query = vim.treesitter.query.get or vim.treesitter.get_query
  local query_ok, query = pcall(get_query, filetype, "highlights")
  if parser_ok and query_ok and ts_ok and ts_configs.is_enabled("highlight", filetype, opts.bufnr) then
    local root = parser:parse()[1]:root()

    local line_highlights = setmetatable({}, {
      __index = function(t, k)
        local obj = {}
        rawset(t, k, obj)
        return obj
      end,
    })

    -- update to changes on Neovim master, see https://github.com/neovim/neovim/pull/19931
    -- TODO(clason): remove when dropping support for Neovim 0.7
    local get_hl_from_capture = (function()
      if vim.fn.has "nvim-0.8" == 1 then
        return function(q, id)
          return "@" .. q.captures[id]
        end
      else
        local highlighter = vim.treesitter.highlighter.new(parser)
        local highlighter_query = highlighter:get_query(filetype)

        return function(_, id)
          return highlighter_query:_get_hl_from_capture(id)
        end
      end
    end)()

    for id, node in query:iter_captures(root, opts.bufnr, 0, -1) do
      local hl = get_hl_from_capture(query, id)
      if hl and type(hl) ~= "number" then
        local row1, col1, row2, col2 = node:range()

        if row1 == row2 then
          local row = row1 + 1

          for index = col1, col2 do
            line_highlights[row][index] = hl
          end
        else
          local row = row1 + 1
          for index = col1, #lines[row] do
            line_highlights[row][index] = hl
          end

          while row < row2 + 1 do
            row = row + 1

            for index = 0, #(lines[row] or {}) do
              line_highlights[row][index] = hl
            end
          end
        end
      end
    end
    opts.line_highlights = line_highlights
  end

  pickers
    .new(opts, {
      prompt_title = "Jump to line",
      prompt_prefix = "  :   ",
      selection_caret = "  ",
      layout_strategy = 'bottom_pane',
      borders = true,
      borderchars = {
        prompt = {"─", "", "─", "", "─", "─", "", ""},
        results = {" ", "", " ", "", "", "", "", ""},
      },
      results_title = false,
      layout_config = {
        height = 0.3,
      },
      finder = finders.new_table {
        results = lines_with_numbers,
        entry_maker = opts.entry_maker or gen_from_buffer_lines(opts),
      },
      sorter = conf.generic_sorter(opts),
      previewer = false,
      attach_mappings = function(prompt_bufnr, map)
        local winid = vim.fn.bufwinid(opts.bufnr)
        actions.move_selection_previous:enhance {
          post = function()
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end
            vim.api.nvim_win_set_cursor(winid, { selection.lnum, 0 })
          end,
        }
        actions.move_selection_next:enhance {
          post = function()
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end
            vim.api.nvim_win_set_cursor(winid, { selection.lnum, 0 })
          end,
        }
        action_set.select:enhance {
          post = function()
            local selection = action_state.get_selected_entry()
            if not selection then
              return
            end

            vim.api.nvim_win_set_cursor(winid, { selection.lnum, 0 })
          end,
        }

        return true
      end,
    })
    :find()
end

M.buffer_jump = function(opts)
  opts = opts or {}
  buffer_jump(opts)
end

return M
