-- Add capabilities to Neovim to use formatters and linters.
local utils = require("config.utils")
local tooling = require("config.tooling")
return {
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
    config = function()
      local conform = require("conform")
      -- Map filetypes to formatter commands.
      conform.formatters_by_ft = tooling.formatters_by_ft()
      -- Override formatters behavior if needed.
      conform.formatters = tooling.export_formatters_specs()
    end,
  },

  -- Linting.
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    cmd = { "LintInfo" },
    config = function()
      local lint = require("lint")
      -- Map filetypes to linters commands.
      lint.linters_by_ft = tooling.linters_by_ft()
    end,
  },
}
