-- nvim v0.8.0
return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup {
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        show_deleted = false,
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation between Hunks.
          map('n', ']h', function()
            if vim.wo.diff then
              vim.cmd.normal({']h', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = 'Gitsigns: Next Hunk' })

          map('n', '[h', function()
            if vim.wo.diff then
              vim.cmd.normal({'[h', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = 'Gitsigns: Previous Hunk'})

          -- Hunk operations.
          map('n', '<leader>gr', gitsigns.reset_hunk, { desc = ' Gitsigns: [G]it [R]eset' })
          map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Gitsigns: [G]it [S]tage toggle' })
          map('n', '<leader>gb', gitsigns.blame, { desc = 'Gitsigns: [G]it [B]lame' })
          map('n', '<leader>gd', gitsigns.toggle_deleted, { desc = 'Gitsigns: [G]it [D]eleted' })
        end
      }

    end
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
  }
}
