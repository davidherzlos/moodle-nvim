return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()

      local gitsigns = require('gitsigns')
      gitsigns.setup {
        signs = {
          add          = { text = '+'  },
          change       = { text = '+'  },
        },
        current_line_blame = true,
        sign_priority = 6,
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        show_deleted = true,

        -- Use this callback to attach some uselful keybindings.
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            print(opts.desc)
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
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Gitsigns: [H]unk [R]eset' })
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Gitsigns: [H]unk [S]tage toggle' })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Gitsigns: [H]unk [P]review' })
          map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = 'Gitsigns: [H]unk [B]lame line' })

        end

      }
    end
  }
}

