return {
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

        -- Navigation between unstaged Hunks.
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({']h', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = 'Git: Next Unstaged Hunk' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({'[h', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = 'Git: Previous Unstaged Hunk'})

        -- Navigation between staged Hunks.
        map('n', ']]h', function()
          if vim.wo.diff then
            vim.cmd.normal({']]h', bang = true})
          else
            gitsigns.nav_hunk('next', { target = 'staged' })
          end
        end, { desc = 'Git: Next Staged Hunk' })

        map('n', '[[h', function()
          if vim.wo.diff then
            vim.cmd.normal({'[[h', bang = true})
          else
            gitsigns.nav_hunk('prev', { target = 'staged' })
          end
        end, { desc = 'Git: Previous Staged Hunk'})

        map('n', '<leader>gp', function()
          gitsigns.toggle_linehl()
        end, { desc = 'Git: [G]it [P]review' })

        map('n', '<leader>gd', function()
          gitsigns.toggle_deleted()
        end, { desc = 'Git: [G]it [D]eleted' })

        map('n', '<leader>hq', function() gitsigns.setqflist('all') end, { desc = 'Git: [H]unk [Q]quickfixList' })
        map('n', '<leader>hl', function() gitsigns.setqflist(0) end, { desc = 'Git: [H]unk [L]ocation List' })

        -- Buffer Hunks.
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = ' Git: [H]unk [R]estore' })
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git: [H]unk [S]tage' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git: [H]unk [U]nstage' })
        map('n', '<leader>gb', gitsigns.blame, { desc = 'Gitsigns: [G]it [B]lame' })
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
