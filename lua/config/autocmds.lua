-- Add autocmd to highlight text when yanking text.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 100 }) -- Highlight for 300ms
  end,
})

-- Formatting.
local conform = require("conform")

-- Add usercmd to toggle format on save.
vim.api.nvim_create_user_command("ConformToggle", function ()
  local state = vim.g.formatters_enabled
  vim.g.formatters_enabled = not state
  vim.print('Formatting is now ' .. (vim.g.formatters_enabled and 'enabled' or 'disabled') .. '.')
end, { desc = "Toggle formatting for the current buffer." })

-- Add autocmd to control the format on save behavior.
vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
  pattern = { "*.sh", "*.php", "*.js", "*.json" },
  callback = function(args)

    if not vim.g.formatters_enabled then
      vim.print('Formatting is not enabled on this buffer.')
      return
    end

    local formatter = conform.list_formatters(args.buf)[1].name
    local formatting_enabled = false

    -- Define default options for formatting.
    local opts = {
      bufnr = args.buf,
      lsp_format = "never",
    }

    -- All formatters except php-cs-fixer can run before save.
    if (args.event == "BufWritePre" and formatter ~= "php-cs-fixer") then
      formatting_enabled = true
      opts.timeout_ms = 5000 -- Add a more reliable timeout.
    end

    -- And only php-cs-fixer can run after save.
    if (args.event == "BufWritePost" and formatter == "php-cs-fixer") then
      formatting_enabled = true
      opts.async = true
    end

    -- Only format the file if the flag is toggled.
    if formatting_enabled == true then
      conform.format(opts, function()
        if opts.async then
          vim.cmd "checktime" -- Update editor with changes.
        end
      end)
    end

  end,
  desc = 'Customize format on save to adapt behavior by filetype.'
})

local lint = require('lint')

-- Add a usercmd to print available linters for this buffer.
vim.api.nvim_create_user_command("LintInfo", function ()
  local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
  vim.print(linters)
end, { desc = "Show availble linters for this buffer." })

-- Add autocmd for linting the file on file save.
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufWritePost" }, {
  pattern = { "*.php" },
  callback = function(args)
    local filetype = vim.bo.filetype
    if filetype == 'php' and args.event == 'InsertLeave' then
      require("lint").try_lint('phpcs')
      return
    end
    if filetype == 'php' and args.event == 'TextChanged' then
      require("lint").try_lint('phpcs')
      return
    end
    if filetype == 'php' and args.event == 'BufWritePost' then
      require("lint").try_lint('phpstan')
      return
    end
    require("lint").try_lint()
  end,
  desc = 'Lint the current file when the buffer is saved.'
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
  desc = 'Lint the current file when the buffer is saved.'
})
