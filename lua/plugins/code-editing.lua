return {
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {}
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
          icon = "",
          color = "error", -- It accepts also hex values.
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Map this keyword too.
        },
        TODO = { icon = "", color = "info" },
        HACK = { icon = "", color = "warning" },
        WARN = { icon = "", color = "warning", alt = { "WARNING" } },
        PERF = { icon = "", alt = { "PERFORMANCE" } },
        NOTE = { icon = "", color = "hint", alt = { "INFO" } },
        TEST = { icon = "", color = "info", alt = { "PASSED", "FAILED" } },
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
      colorcolumn = "100",
      custom_colorcolumn = {
        python = "80", php = "132"
      },
      scope = 'line'
    }
  },
  {
    "folke/noice.nvim",
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
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        left = "",
        right = "",
        arrow = "",
        up_arrow = "",
      },
      blend = {
        factor = 0.20
      },
      options = {
        multiple_diag_under_cursor = true
      }
    }
  },
  {
    "github/copilot.vim"
  },
}
