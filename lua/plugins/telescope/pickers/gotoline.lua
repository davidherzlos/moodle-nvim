vim.keymap.set('n', '<leader>gl', function ()
  -- Get the current buffer info.
  local bufnr = vim.api.nvim_get_current_buf()
  local winnr = vim.api.nvim_get_current_win()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  -- Create a qflist from each line from the buffer.
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local lines_with_numbers = {}
  for lnum, line in ipairs(lines) do
    if string.match(line, "%S") ~= nil then
      table.insert(lines_with_numbers, {
        bufnr = bufnr,
        lnum = lnum,
        col = 0,
        text = line,
      })
    end
  end

  -- Copied code to add treesitter highlights.
  local ts_ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
  if ts_ok then
    filetype = ts_parsers.ft_to_lang(filetype)
  end
  local _, ts_configs = pcall(require, "nvim-treesitter.configs")

  local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr, filetype)
  local get_query = vim.treesitter.query.get or vim.treesitter.get_query
  local query_ok, query = pcall(get_query, filetype, "highlights")
  if parser_ok and query_ok and ts_ok and ts_configs.is_enabled("highlight", filetype, bufnr) then
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

    for id, node in query:iter_captures(root, bufnr, 0, -1) do
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
  -- Modify the lines_with_numbers table to include highlights
  for _, item in ipairs(lines_with_numbers) do
    if line_highlights[item.lnum] then
      item.highlights = {
        {
          col = 0,
          end_col = #item.text,
          hl_group = line_highlights[item.lnum][0] or line_highlights[item.lnum][1] or "",
        }
      }
    end
  end
  end

  local action = ' ' -- r, a, etc.
  vim.fn.setqflist(lines_with_numbers, action)
  vim.cmd('copen')
end)


