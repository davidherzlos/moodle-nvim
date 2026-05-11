return {
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ",
          color = "error", -- It accepts also hex values.
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Map this keyword too.
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = "󰒡 ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = "󰺓 ", color = "info", alt = { "PERFORMANCE" } },
        NOTE = { icon = " ", color = "info", alt = { "INFO", "SPIKE" } },
        TEST = { icon = " ", color = "info", alt = { "PASSED", "FAILED" } },
        REFACTOR = { icon = "󰁨 ", color = "info", alt = { "STRUCTURE", "REF" } },
      },
    }
  },
  -- Diagnostics inline.
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      preset = 'powerline',
      signs = { arrow = "" },
      options = {
        show_source = true,
        show_code = false, -- Display the diagnostic code of diagnostics (e.g., "F401", "no-dupe-args").
        multiple_diag_under_cursor = true,
        enable_on_insert = false,
        throttle = 0,
      }
    },
  },
  {
    'yorickpeterse/nvim-pqf',
    event = "UIEnter",
    config = function ()
      require('pqf').setup({
        signs = {
          error = { text = ' ', hl = 'DiagnosticSignError' },
          warning = { text = ' ', hl = 'DiagnosticSignWarn' },
          info = { text = ' ', hl = 'DiagnosticSignInfo' },
          hint = { text = ' ', hl = 'DiagnosticSignHint' },
        },
        max_filename_length = 65,
        filename_truncate_prefix = '[...]',
      })
    end
  },
}
