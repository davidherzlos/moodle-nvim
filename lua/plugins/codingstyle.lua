local project = require("config.utils.project")

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
        php = { project.moodle_project and "phpcbf" or "php-cs-fixer" },
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
        php = { "phpstan", "phpcs" },
        javascript = { "biome" },
        json = { "biome" },
        typescript = { "ts_ls" },
      }

      -- Override formatters behavior if needed.
      if project.moodle_project() then
        -- Moodle needs more memory so phpstan can work properly.
        vim.print("Moodle codebase detected, increasing phpstan memory limit.")
        table.insert(lint.linters.phpstan.args, '--memory-limit=500M')
      end

    end
  },
}
