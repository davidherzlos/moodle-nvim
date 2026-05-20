return {
  -- Vim fugitive to integrate a wide range of git operations on vim cmd.
  {
    'tpope/vim-fugitive',
    dependencies = {
      'nvim-mini/mini.nvim',
      version = false,
    },
    config = function ()
      -- MiniDiff to highlight signs with git changes.
      require('mini.diff').setup({
        view = {
          signs = { add = '█', change = '█', delete = '█' },
        },
      })
      vim.keymap.set('n', '<leader>wp', "<cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = 'Preview changes' })

      -- Add Keymaps to open diff split views for changes and conflicts.
      vim.keymap.set('n', '<leader>wd', function ()
        vim.cmd('Gvdiffsplit')
        vim.opt.laststatus = 3
      end, { desc = 'Worktree diff' })

      vim.keymap.set('n', '<leader>id', function ()
        vim.cmd('Gvdiffsplit HEAD')
        vim.opt.laststatus = 3
      end, { desc = 'Index diff' })

      vim.keymap.set('n', '<leader>md', function ()
        vim.cmd('Gvdiffsplit!')
        vim.opt.laststatus = 3
      end, { desc = 'Merge conflict diff' })

      -- Changes to lists.
      vim.keymap.set('n', '<leader>wc', function()
        vim.cmd('Git difftool')
      end, { noremap = true, silent = true, desc = 'Worktree changes' })

      vim.keymap.set('n', '<leader>ic', function()
        vim.cmd('Git difftool --staged')
      end, { noremap = true, silent = true, desc = 'Index changes' })

      vim.keymap.set('n', '<leader>mc', function()
        vim.cmd('Git mergetool')
      end, { noremap = true, silent = true, desc = 'Merge conflicts' })
    end
  },
}
