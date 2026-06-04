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
      end, { desc = 'Worktree diffsplit' })

      vim.keymap.set('n', '<leader>id', function ()
        vim.cmd('Gvdiffsplit HEAD')
      end, { desc = 'Index diff' })

      vim.keymap.set('n', '<leader>md', function ()
        vim.cmd('Gvdiffsplit!')
      end, { desc = 'Merge conflict diffsplit' })

      -- Changes to lists.
      vim.keymap.set('n', '<leader>wc', function()
        vim.cmd('Git difftool')
      end, { noremap = true, silent = true, desc = 'Worktree changes' })

      vim.keymap.set('n', '<leader>ic', function()
        vim.cmd('Git difftool --staged')
      end, { noremap = true, silent = true, desc = 'Index changes' })

      vim.keymap.set('n', '<leader>mc', function()
        vim.cmd('Git mergetool')
      end, { noremap = true, silent = true, desc = 'Merging conflicts' })
    end
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function ()
      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
      vim.g.lazygit_floating_window_scaling_factor = 1 -- scaling factor for floating window
      vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'} -- customize lazygit popup window border characters
      vim.g.lazygit_floating_window_use_plenary = 1 -- use plenary.nvim to manage floating window if available
      vim.g.lazygit_use_neovim_remote = 0 -- fallback to 0 if neovim-remote is not installed
      vim.g.lazygit_on_exit_callback = nil -- optional function callback when exiting lazygit (useful for example to refresh some UI elements after lazy git has made some changes)
      vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
      vim.g.lazygit_config_file_path = '' -- custom config file path
      -- OR
      vim.g.lazygit_config_file_path = {} -- table of custom config file paths
    end
  }
}
