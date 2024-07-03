return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()

      local gitsigns = require('gitsigns')
      gitsigns.setup {
        signs = {
          add          = { text = '󰐕' },
          change       = { text = '󰐕' },
          delete       = { text = '󰍴' },
          topdelete    = { text = '‾' },
          changedelete = { text = 'ﰣ' },
       },
        signs_staged = {
          add          = { text = '󰐕' },
          change       = { text = '󰐕' },
          delete       = { text = '󰍴' },
          topdelete    = { text = '‾' },
          changedelete = { text = 'ﰣ' },
        },
        current_line_blame = true,
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        show_deleted = false,

        -- Use this callback to attach some uselful keybindings.
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation between Hunks.
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = 'Gitsigns: Next Hunk' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = 'Gitsigns: Previous Hunk'})

          -- Hunk operations.
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = ' Gitsigns: [H]unk [R]eset' })
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Gitsigns: [H]unk [S]tage toggle' })
           map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Gitsigns: [H]unk [P]review' })
          map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = 'Gitsigns: [H]unk [B]lame line' })
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'Gitsigns: [T]oggle [D]eleted' })

        end

      }

    end
  }
}

