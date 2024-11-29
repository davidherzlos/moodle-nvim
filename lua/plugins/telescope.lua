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
        pickers = {
          lsp_definitions = {
            show_line = false,
          },
          lsp_references = {
            show_line = false,
          },
          lsp_implementations = {
            show_line = false,
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<M-n>"] = require("telescope.actions").move_selection_next,
              ["<M-p>"] = require("telescope.actions").move_selection_previous,
              ["<M-c>"] = require("telescope.actions").close,
              ["<M-x>"] = require("telescope.actions").select_horizontal,
              ["<M-v>"] = require("telescope.actions").select_vertical,
              ["<M-u>"] = require("telescope.actions").preview_scrolling_up,
              ["<M-d>"] = require("telescope.actions").preview_scrolling_down,
              ["<M-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
              ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            },
            n = {
              ["<M-x>"] = require("telescope.actions").select_horizontal,
              ["<M-v>"] = require("telescope.actions").select_vertical,
              ["<M-u>"] = require("telescope.actions").preview_scrolling_up,
              ["<M-d>"] = require("telescope.actions").preview_scrolling_down,
              ["<M-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
              ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            }
          },
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              width = { padding = 0 },
              height = { padding = 0 },
              preview_width = 0.55,
            };
          },
          sorting_strategy = 'ascending',
          preview = {
            treesitter = true
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
      vim.keymap.set('n', '<leader>sc', builtin.git_status, { desc = '[S]earch Git [C]hanges' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch [W]ord' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>s.', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end)
      vim.keymap.set('n', '<leader>sg', live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sG', search_dir_picker.search_dir, { desc = '[Search] by [G]rep in directory' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sl', builtin.resume, { desc = '[S]earch [L]ast' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })

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

