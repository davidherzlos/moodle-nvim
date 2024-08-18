return {
  -- Telescope fuzzy finder.
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- I dont know what plenary is for but many plugins related to telescope require it.
      {
        'nvim-lua/plenary.nvim'
      },
      -- This is useful for pretty icons.
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font
      },
      -- Better files fuzzy finds using fzf.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end
      },
      -- Telescope UI for quick code actions.
      {
        'nvim-telescope/telescope-ui-select.nvim',
      },
      -- Live grep args for enabling passing args to the grep command.
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        -- For major updates, this must be adjusted manually.
        version = '^1.0.0',
      },
      -- Choose the directory before using live grep.
      {
        'smilovanovic/telescope-search-dir-picker.nvim'
      },
      { "tsakirist/telescope-lazy.nvim" },
      {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
          require'window-picker'.setup()
        end,
      }
    },
    -- Configuration for Telescope.
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              width = { padding = 0 },
              height = { padding = 0 },
              preview_width = 0.5,
            };
          },
          sorting_strategy = 'ascending',
          preview = {
            treesitter = false
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim" -- add this value
          },
          mappings = {
            i = {
              ['<C-g>'] = function(prompt_bufnr)
                -- Use nvim-window-picker to choose the window by dynamically attaching a function
                local action_set = require('telescope.actions.set')
                local action_state = require('telescope.actions.state')

                local picker = action_state.get_current_picker(prompt_bufnr)
                picker.get_selection_window = function(picker, entry)
                  local picked_window_id = require('window-picker').pick_window({hint='floating-big-letter'}) or vim.api.nvim_get_current_win()
                  vim.print(require('window-picker').pick_window({ hint = 'floating-big-letter'}))
                  -- Unbind after using so next instance of the picker acts normally
                  picker.get_selection_window = nil
                  return picked_window_id
                end

                return action_set.edit(prompt_bufnr, 'edit')
              end,
            },
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          },
        }
      })

      -- Enable telescope extensions if they are installed.
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("live_grep_args")

      require("telescope").load_extension("search_dir_picker")

      local builtin = require("telescope.builtin")
      local live_grep_args = require('telescope').extensions.live_grep_args
      local search_dir_picker = require('search_dir_picker')

      -- Telescope pickers keymaps.
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sg', live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sG', search_dir_picker.search_dir, { desc = '[Search] by [G]rep in directory' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

      -- keeps track of current `tabline` and `statusline`, so we can restore it after closing telescope
      local temp_showtabline
      local temp_laststatus

      function _G.global_telescope_find_pre()
        temp_showtabline = vim.o.showtabline
        temp_laststatus = vim.o.laststatus
        vim.o.showtabline = 0
        vim.o.laststatus = 0
      end

      function _G.global_telescope_leave_prompt()
        vim.o.laststatus = temp_laststatus
        vim.o.showtabline = temp_showtabline
      end

      vim.cmd([[
          augroup MyAutocmds
          autocmd!
          autocmd User TelescopeFindPre lua global_telescope_find_pre()
          autocmd FileType TelescopePrompt autocmd BufLeave <buffer> lua global_telescope_leave_prompt()
          augroup END
          ]])
    end
  },
}

