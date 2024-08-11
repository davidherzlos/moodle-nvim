---@diagnostic disable-next-line: undefined-field
local cwd = vim.loop.cwd()
local php = {}

-- Returns true if the current project is a Moodle codebase.
php.is_moodle_codebase = function ()
  return vim.fn.filereadable(cwd .. '/lib/moodlelib.php') == 1 and true or false
end

-- Formatters config.
local conform = require("conform")

-- Map filetypes to formatter commands.
conform.formatters_by_ft = {
  sh = { "beautysh" },
  php = { php.is_moodle_codebase() and "phpcbf" or "php-cs-fixer" }
}

-- Override formatters behavior if needed.
conform.formatters = {
  beautysh = {
    prepend_args = {
      "--indent-size=2",
      "--force-function-style=paronly",
    },
  },
  ['php-cs-fixer'] = {
    args = {
      "fix",
      "$FILENAME",
      "--using-cache=no",
      "--rules=@Symfony",
      "--no-interaction",
      "--quiet",
    },
  },
}

-- Add autocmd for some required initial state in the buffer.
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function ()
    -- Hide virtual text so the diagnostic perline can work.
    vim.diagnostic.config({
      virtual_text = false
    })
    -- Toggle on formatters_enabled on the current buffer.
    vim.b.formatters_enabled = true
  end,
  desc = 'Hide virtual text and set correct formatting toggle flag.'
})

-- Add usercmd to toggle formatting for the current buffer.
vim.api.nvim_create_user_command("ConformToggle", function ()
  local state = vim.b.formatters_enabled
  vim.b.formatters_enabled = not state
end, { desc = "Toggle formatting for the current buffer." })

-- Add autocmd for custom format on save behavior.
vim.api.nvim_create_autocmd({ "BufWritePre", "BufWritePost" }, {
  pattern = { "*.sh", "*.php" },
  callback = function(args)

    if not vim.b.formatters_enabled then
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

-- Linters config.
local lint = require('lint')

-- Map filetypes to linters commands.
lint.linters_by_ft = {
  php = { "phpstan", "phpcs" }
}

-- Override formatters behavior if needed.
if php.is_moodle_codebase() then
  -- Moodle needs more memory so phpstan can work properly.
  vim.print("Moodle codebase detected, increasing phpstan memory limit.")
  table.insert(lint.linters.phpstan.args, '--memory-limit=500M')
end

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

