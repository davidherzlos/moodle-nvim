local utils = require("config.utils")

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
    },
    config = function ()
      local conform = require("conform")

      -- Map filetypes to formatter commands.
      conform.formatters_by_ft = {
        sh = { "beautysh" },
        php = { utils.is_moodle_project and "phpcbf" or "php-cs-fixer" },
        javascript = { "biome" },
        json = { "biome" }
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

    end
  },
  -- Linting.
  {
    'mfussenegger/nvim-lint',
    lazy = true,
    cmd = { "LintInfo" },
    config = function()
      local lint = require('lint')

      -- Map filetypes to linters commands.
      lint.linters_by_ft = {
        php = { "phpcs", "phpstan" },
        javascript = { "biome" },
        json = { "biome" },
        typescript = { "ts_ls" },
      }

      -- Override formatters behavior if needed.
      if utils.is_moodle_project() then
        -- Moodle needs more memory so phpstan can work properly.
        table.insert(lint.linters.phpstan.args, '--memory-limit=500M')
      end
    end
  },
}
