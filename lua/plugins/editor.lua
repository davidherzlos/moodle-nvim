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
          icon = "󰁨 ",
          color = "error", -- It accepts also hex values.
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Map this keyword too.
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = "󰒡 ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = "󰺓 ", alt = { "PERFORMANCE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "SPIKE" } },
        TEST = { icon = " ", color = "info", alt = { "PASSED", "FAILED" } },
        REFACTOR = { icon = " ", color = "info", alt = { "STRUCTURE", "REF" } },
      },
    }
  },
  -- Some UI improvements for the editor.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = 'cmdline',
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon =  "", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
          input = { view = "cmdline_input", icon = "󰥻 " },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        hover = {
          enabled = false
        },
        signature = {
          enabled = false
        }
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = { "MunifTanjim/nui.nvim" }
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
