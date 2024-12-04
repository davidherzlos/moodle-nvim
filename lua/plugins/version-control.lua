return {
  {
    'tpope/vim-fugitive',
    config = function ()
      -- NOTE: Could be convenient to map this commands.
      -- vim.keymap.set('n', '<leader>gd', "<cmd>Gitdiffsplit<cr>", { desc = 'Git: [G]it [H]unks' })
      -- vim.keymap.set('n', '<leader>gd', "<cmd>Gitvdiffsplit<cr>", { desc = 'Git: [G]it [H]unks' })
      -- vim.keymap.set('n', '<leader>gd', "<cmd>Gread<cr>", { desc = 'Git: [G]it [H]unks' })
      -- vim.keymap.set('n', '<leader>gd', "<cmd>Gwrite<cr>", { desc = 'Git: [G]it [H]unks' })
      -- vim.keymap.set('n', '<leader>gd', "<cmd>Gedit :0<cr>", { desc = 'Git: [G]it [H]unks' })
      -- vim.keymap.set('n', '<leader>gd', "<cmd>diffget<cr>", { desc = 'Git: [G]it [H]unks' })
      -- vim.keymap.set('n', '<leader>gd', "<cmd>diffput<cr>", { desc = 'Git: [G]it [H]unks' })

      -- Keymap to open a vimsplit view for merge conflicts.
      vim.keymap.set('n', '<leader>gm', "<cmd>Gvdiffsplit!<cr>", { desc = 'Git: [G]it [M]erge conflicts' })

      -- Keymaps to get qflist and loclist from the git index.
      vim.keymap.set('n', '<leader>ic', function()
        vim.cmd('Git! difftool --staged')
      end, { noremap = true, silent = true, desc = 'Git: [I]ndex qflist' })

      vim.keymap.set("n", "<leader>il", function()
        vim.cmd('Git! difftool --staged %') vim.cmd("cclose")
        vim.fn.setloclist(0, vim.fn.getqflist()) vim.cmd("lopen")
      end, { noremap = true, silent = true, desc = "Git: [I]ndex [L]oclist" })

    end
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '┃' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '┃' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      max_file_length = 40000, -- Disable if file is longer than this number of lines.
      auto_attach = true,
      numhl      = true,
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>gp', function()
          gitsigns.toggle_linehl()
        end, { desc = 'Git: [G]it [P]review' })

        map('n', '<leader>gd', function()
          gitsigns.toggle_deleted()
        end, { desc = 'Git: [G]it [D]eleted' })

        -- Keymaps to stage, unstage, restore and blame.
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = ' Git: [H]unk [R]estore' })
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git: [H]unk [S]tage' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git: [H]unk [U]nstage' })
        map('n', '<leader>gb', gitsigns.blame, { desc = 'Gitsigns: [G]it [B]lame' })

        -- Keymaps to get qflist and loclist from hunk.
        vim.keymap.set('n', '<leader>hc', function()
          require("gitsigns").setqflist("all", { use_location_list = false })
        end, { noremap = true, silent = true, desc = 'Git: [H]unks qflist' })

        vim.keymap.set('n', '<leader>hl', function()
          require('gitsigns').setqflist(0, { use_location_list = true })
        end, { noremap = true, silent = true, desc = 'Git: [H]unks loclist' })
      end
    },
  },
  {
    "kdheepak/lazygit.nvim",
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
