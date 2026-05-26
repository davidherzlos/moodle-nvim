return {
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')

      wk.setup({
        preset = 'classic',
        icons = {
          group = ' +',
        },
        sort = { 'manual' },
      })

      wk.add({
        -- Agentic coding.
        { '<leader>a', group = 'Agentic coding', icon = { icon = '󱙺' } },

        -- Files/Navigation.
        { '<leader>b', group = 'Bookmarks', icon = { icon = '󰆤' } },
        { '<leader>f', group = 'Files', icon = { icon = '' } },

        -- Grep
        { '<leader>g', group = 'Grep', icon = { icon = '󰑑' } },

        -- LSP/Pickers.
        { '<leader>s', group = 'Symbols (lsp)', icon = { icon = '' } },
        { '<leader>r', group = 'Refactor', icon = { icon = '󰁨' } },
        { '<leader>q', group = 'Quick pick', icon = { icon = '' } },

        -- Diagnostics.
        { '<leader>d', group = 'Diagnostics', icon = { icon = '' } },

        -- Git contexts.
        { '<leader>w', group = 'Git worktree', icon = { icon = '' } },
        { '<leader>i', group = 'Git index', icon = { icon = '' } },
        { '<leader>m', group = 'Git merge', icon = { icon = '' } },

        -- Debugger.
        { '<leader>x', group = 'Debug', icon = { icon = '' } },
        { '<leader>xu', group = 'Debug UI', icon = { icon = '' } },
        { '<leader>xv', group = 'Debug view', icon = { icon = '' } },

        -- Editor utilities.
        { '<leader>t', group = 'Testing', icon = { icon = '' } },
        { '<leader>.', group = 'Scratch buffer', icon = { icon = '󰇘' } },


      })
    end,
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = true })
        end,
        desc = 'Keymaps (all)',
      },
    },
  },
}
