
-- Add autocmd to highlight text when yanking text.
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 100 }) -- Highlight for 300ms
  end,
})

-- Formatting.
local tooling = require("config.tooling")
local conform = require("conform")

-- Add autocmd to control the format on save behavior.
vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
  pattern = { '*' },
  callback = function(args)
    local filetype = vim.bo.filetype
    local filetype_supported = vim.tbl_contains(vim.tbl_keys(tooling.formatters_by_ft()), filetype)

    -- Some guards.
    if not vim.g.formatters_enabled or not filetype_supported then
      return
    end
    local formatters = conform.list_formatters(args.buf)
    if vim.tbl_isempty(formatters) then
      return
    end

    -- Define options for formatting.
    local formatter = formatters[1].name
    local opts = {
      bufnr = args.buf,
      lsp_format = "never",
    }

    vim.print("File will be formatted using " .. formatter)

    -- All formatters except php-cs-fixer can run before save.
    if args.event == "BufWritePre" and formatter ~= "php-cs-fixer" then
      opts.timeout_ms = 5000 -- TEST: adjust this timeout.
      conform.format(opts)
      return
    end

    -- And only php-cs-fixer can run after save.
    if args.event == "BufWritePost" and formatter == "php-cs-fixer" then
      opts.async = true
      conform.format(opts, function()
        -- Update editor when the file externally changes.
        vim.cmd("checktime")
      end)
    end

  end,
  desc = "Autocmd to customize Conform formatting.",
})

-- Linting.
local lint = require("lint")

-- One linter at a time.
local function debounce(fn, delay)
  local timer = (vim.uv or vim.loop).new_timer()
  return function()
    timer:stop()
    timer:start(delay, 0, vim.schedule_wrap(fn))
  end
end

-- Add autocmd for linting the file on file save.
vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "TextChanged" }, {
  pattern = { '*' },
  callback = debounce(function ()
    local filetype = vim.bo.filetype
    local filetype_supported = vim.tbl_contains(vim.tbl_keys(tooling.linters_by_ft()), filetype)
    if not filetype_supported then
      return
    end
    local relative_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
    vim.notify("Linting " .. relative_path)
    lint.try_lint()
  end, 1000),
  desc = "Lint the current file when the buffer is saved.",
})

-- Add autocmd to toggle diagnostics on insertmode.
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  pattern = { "*" },
  callback = function(args)
    if args.event == "InsertEnter" then
      vim.diagnostic.enable(false)
    end
    if args.event == "InsertLeave" then
      vim.diagnostic.enable(true)
    end
  end,
  desc = "Lint the current file when the buffer is saved.",
})

-- Add autocmd for adjusting lines on qflists and loclists.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.linebreak = false
  end,
})

-- Add autocmd for allowing LSP renaming on mini-files.
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

-- Terminal autocmds.
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.schedule(function()
      vim.opt_local.cursorline = false
    end)
  end,
})
