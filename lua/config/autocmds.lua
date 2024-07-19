-- Define all cmds you ned here.

-- Codingstyle: formatting.
vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
  pattern = { "*.sh", "*.php" },
  callback = function(args)

    local conform = require("conform")
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
})

-- Codingstyle: linting.
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.sh", "*.php" },
  callback = function()
    require("lint").try_lint()
  end
})

-- Toggle diagnostics virtual text hide on insert and show after save.
vim.api.nvim_create_autocmd({ "InsertEnter", "BufWritePost" }, {
  pattern = { "*" },
  callback = function (args)
    vim.diagnostic.config({
      --virtual_text = args.event == "BufWritePost"
      virtual_text = false
    })
  end
})

-- Add a command to know which Linters are enabled in the buffer.
vim.api.nvim_create_user_command("LintInfo", function ()
  vim.print(require("lint")._resolve_linter_by_ft(vim.bo.filetype))
end, { desc = "Show information about Lint NvimLint Linters" })

