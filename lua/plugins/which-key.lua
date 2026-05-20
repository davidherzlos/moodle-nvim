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
          group = ' ',
        },
        sort = { 'desc' },
      })

      wk.add({
        -- Files.
        { '<leader>f', group = 'Fuzzy find', icon = { icon = '' } },
        { '<leader>e', group = 'Explorer', icon = { icon = '' } },

        -- LSP / Code intelligence.
        { '<leader>s', group = 'Search (LSP)', icon = { icon = '' } },
        { '<leader>r', group = 'Refactor', icon = { icon = '󰁨' } },

        -- Diagnostics.
        { '<leader>d', group = 'Diagnostics', icon = { icon = '' } },

        -- Debugger.
        { '<leader>x', group = 'Debug', icon = { icon = '' } },
        { '<leader>xu', group = 'Debug UI', icon = { icon = '' } },
        { '<leader>xv', group = 'Debug view', icon = { icon = '' } },

        -- Grep
        { '<leader>g', group = 'Grep', icon = { icon = '󰑑' } },

        -- Git contexts.
        { '<leader>w', group = 'Git worktree', icon = { icon = '' } },
        { '<leader>i', group = 'Git index', icon = { icon = '' } },
        { '<leader>m', group = 'Git merge', icon = { icon = '' } },

        -- Navigation.
        { '<leader>n', group = 'Navigation', icon = { icon = '󰆤' } },
        { '<leader>q', group = 'Quick pick', icon = { icon = '' } },

        -- Editor utilities.
        { '<leader>t', group = 'Testing', icon = { icon = '' } },
        { '<leader>.', group = 'Scratch buffer', icon = { icon = '󰇘' } },

        -- Agentic coding.
        { '<leader>a', group = 'Agentic coding', icon = { icon = '󱙺' } },
      })
    end,
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = true })
        end,
        desc = 'Keymaps',
      },
    },
  },
}
