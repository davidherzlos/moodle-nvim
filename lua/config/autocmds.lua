local conform = require("conform")

-- Add usercmd to toggle formatting for the current buffer.
vim.api.nvim_create_user_command("ConformToggle", function ()
  local state = vim.g.formatters_enabled
  vim.g.formatters_enabled = not state
  vim.print('Formatting is now ' .. (vim.g.formatters_enabled and 'enabled' or 'disabled') .. '.')
end, { desc = "Toggle formatting for the current buffer." })

-- Add autocmd for custom format on save behavior.
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

-- Add autocmd for linting the file on file save.
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.sh", "*.php" },
  callback = function()
    require("lint").try_lint()
  end,
  desc = 'Lint the current file when the buffer is saved.'
})

-- Add a usercmd to print available linters for this buffer.
vim.api.nvim_create_user_command("LintInfo", function ()
  local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
  vim.print(linters)
end, { desc = "Show availble linters for this buffer." })

