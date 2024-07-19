-- Add capabilities to neovim to use formatters and linters.
return {
  -- Tool installation.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "beautysh",
        "php-cs-fixer",
        "phpstan",
        "phpcs",
      },
    },
  },
  -- Formatting.
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufEnter" },
    cmd = { "ConformInfo" },
    opts = {
      -- Log all errors by default.
      notify_on_error = true,
      log_level = vim.log.levels.ERROR,
    }
  },
  -- Linting.
  {
    'mfussenegger/nvim-lint',
    lazy = true,
    event = { "TextChanged" },
    cmd = { "LintInfo" }
  },
}

