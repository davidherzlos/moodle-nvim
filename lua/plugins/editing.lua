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
  }
}
