return {
  -- MiniDiff to highlight signs with git changes.
  {
    'echasnovski/mini.nvim',
    config = function ()
      vim.keymap.set('n', '<leader>Gp', function ()
        vim.cmd('MiniDiff.toggle_overlay()')
      end, { desc = '[G]it [p]review worktree'})
    end
  },
  -- Vim fugitive to integrate a wide range of git operations on vim cmd.
  {
    'tpope/vim-fugitive',
    config = function ()
      require('mini.diff').setup()

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
  -- Lazygit foe more visual git users.
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit: [G]it [C]onsole" },
      { "<leader>lG", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit: [G]it [C]onsole" }
    },
    config = function ()
      vim.g.lazygit_floating_window_scaling_factor = 1.0 -- scaling factor for floating window
      vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available
    end
  },
}

