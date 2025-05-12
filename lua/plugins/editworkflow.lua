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
          icon = " ",
          color = "error", -- It accepts also hex values.
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Map this keyword too.
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
        PERF = { icon = " ", alt = { "PERFORMANCE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "SPIKE" } },
        TEST = { icon = " ", color = "info", alt = { "PASSED", "FAILED" } },
      },
    }

  },
  -- Add this little plugin to jum anywhere with 3 keystrokes at most.
  { 'ggandor/leap.nvim',
    config = function()
      vim.keymap.set('n',        's', '<Plug>(leap)')
      vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
      vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
      vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
    end
  },
  -- Highligh color column when needed by filetype.
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      disabled_filetypes = {
        "snacks_dashboard",
        "qf",
      },
      colorcolumn = "100",
      custom_colorcolumn = {
        python = "80", php = "132", lua = "100", javascript = "100",
      },
      scope = 'line'
    }
  },
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      cmdline = {
        format = {
          search_down = { kind = "search", pattern = "^/", icon = "Search  ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon =  "Search  ", lang = "regex" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󱏘 " },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      preset = 'powerline',
      signs = {
        arrow = "",
      },
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
    enabled = true,
    event = "UIEnter",
    config = function ()
      require('pqf').setup({
        signs = {
          error = { text = ' ', hl = 'DiagnosticSignError' },
          warning = { text = '󰞏 ', hl = 'DiagnosticSignWarn' },
          info = { text = ' ', hl = 'DiagnosticSignInfo' },
          hint = { text = ' ', hl = 'DiagnosticSignHint' },
        },
      })
    end
  },
}
