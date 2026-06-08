return {
  -- Show signature help and parameter hints.
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      debug = false, -- set to true to enable debug logging
      log_path = vim.fn.stdpath("log") .. "/lsp_signature.log", -- log dir when debug is true
      -- default is  ~/.cache/nvim/lsp_signature.log
      verbose = false, -- show debug line number
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default
      wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap
      close_timeout = 4000, -- close floating window after ms when laster parameter is entered
      fix_pos = true,  -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true,
      hint_prefix = " ",
      hint_scheme = "DiagnosticVirtualTextInfo",
      hint_inline = false,
      handler_opts = {
        border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
      },
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
      padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
      toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
    },
  },
  -- Tabline customization.
  {
    'nanozuki/tabby.nvim',
    config = function()
      require('tabby').setup({
        preset = 'active_wins_at_tail',
        option = {
          nerdfont = true,              -- whether use nerdfont
          tab_name = {
            name_fallback = function(tabid)
              return ''
            end,
          },
          buf_name = {
            mode = 'tail', -- or 'relative', 'tail', 'shorten'
          },
        },
      })
    end,
  },
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
      })
    end
  },
}
