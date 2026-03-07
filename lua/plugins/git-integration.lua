return {
  -- Vim fugitive to integrate a wide range of git operations on vim cmd.
  {
    'tpope/vim-fugitive',
    config = function ()
      -- Add Keymaps to open diff split views for changes and conflicts.
      vim.keymap.set('n', '<leader>Gwd', function ()
        vim.cmd('Gvdiffsplit')
        vim.opt.laststatus = 3
      end, { desc = '[G]it [w]orktree [d]iffsplit' })

      vim.keymap.set('n', '<leader>Gid', function ()
        vim.cmd('Gvdiffsplit HEAD')
        vim.opt.laststatus = 3
      end, { desc = '[G]it [i]ndex [d]iffsplit' })

      vim.keymap.set('n', '<leader>Gmd', function ()
       vim.cmd('Gvdiffsplit!')
        vim.opt.laststatus = 3
      end, { desc = '[G]it [m]erge [d]iffsplit' })

      -- Add keymaps to open qflists and loclists of changes to the worktree.
      vim.keymap.set('n', '<leader>Gwc', function()
        vim.cmd('Git difftool')
      end, { noremap = true, silent = true, desc = '[G]it [w]orktree [c]open' })

      vim.keymap.set("n", "<leader>Gwl", function()
        vim.cmd('Git difftool %') vim.cmd("cclose")
        vim.fn.setloclist(0, vim.fn.getqflist()) vim.cmd("lopen")
      end, { noremap = true, silent = true, desc = '[G]it [w]orktree [l]open' })

      -- Add keymaps to open qflists and loclists of changes to the index.
      vim.keymap.set('n', '<leader>Gic', function()
        vim.cmd('Git difftool --staged')
      end, { noremap = true, silent = true, desc = '[G]it [i]ndex [c]open' })

      vim.keymap.set("n", "<leader>Gil", function()
        vim.cmd('Git difftool --staged %') vim.cmd("cclose")
        vim.fn.setloclist(0, vim.fn.getqflist()) vim.cmd("lopen")
      end, { noremap = true, silent = true, desc = '[G]it [i]ndex [l]open' })

      -- Keymaps to open qflists and loclists of merge conflicts.
      vim.keymap.set('n', '<leader>Gmc', function()
        vim.cmd('Git mergetool')
      end, { noremap = true, silent = true, desc = '[G]it [m]erge [c]open' })

      vim.keymap.set("n", "<leader>Gml", function()
        vim.cmd('Git mergetool %') vim.cmd("cclose")
        vim.fn.setloclist(0, vim.fn.getqflist()) vim.cmd("lopen")
      end, { noremap = true, silent = true, desc = '[G]it [m]erge [l]open' })
    end
  },
}
