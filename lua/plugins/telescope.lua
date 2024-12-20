return {
  -- Telescope fuzzy finder.
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      -- I dont know what plenary is for but many plugins related to telescope require it.
      {
        "neovim/nvim-lspconfig",
      },
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
          cache_picker = {
            num_pickers = 10,
            limit_entries = 1000,
          },
          mappings = {
            i = {
              ["<C-n>"] = require("telescope.actions").move_selection_next,
              ["<C-p>"] = require("telescope.actions").move_selection_previous,
              ["<esc>"] = require("telescope.actions").close,
              ["<C-x>"] = require("telescope.actions").select_horizontal,
              ["<C-v>"] = require("telescope.actions").select_vertical,
              ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
              ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
              ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
            },
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
      local builtin = require("telescope.builtin")
      local live_grep_args = require('telescope').extensions.live_grep_args

      -- Telescope pickers keymaps.
      vim.keymap.set('n', '<leader>sc', builtin.git_status, { desc = '[S]earch Git [C]hanges' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch [W]ord' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>s.', function() builtin.find_files({ cwd = vim.fn.expand('%:p:h') }) end)
      vim.keymap.set('n', '<leader>sg', live_grep_args.live_grep_args, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>s/', function() live_grep_args.live_grep_args({ cwd = vim.fn.expand('%:p:h') }) end)
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sl', builtin.resume, { desc = '[S]earch [L]ast' })
      vim.keymap.set('n', '<leader>sp', builtin.pickers, { desc = '[S]earch cached [P]ickers' })
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

      -- Language server Protocol and Telescope.
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)

          local opts = function(description)
            return { buffer = event.buf, desc = description}
          end

          local telescope = require('telescope.builtin')
          -- Configure some minimal keybindings.
          vim.keymap.set('n', '<leader>sd', function() telescope.lsp_definitions({ jump_type = 'never' }) end, opts('LSP: [S]earch [D]efinition'))
          vim.keymap.set('n', '<leader>si', telescope.lsp_implementations, opts('LSP: [S]earch [I]mplementations'))
          vim.keymap.set('n', '<leader>sr', telescope.lsp_references, opts('LSP: [S]earch [R]eferences'))
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('LSP: [R]ename Symbol'))
          vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts('LSP: [D]ocument Symbols'))
          vim.keymap.set('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, opts('LSP: Dynamic [W]orkspace Symbols'))
          vim.keymap.set("n", "<leader>Ws", function()
            vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
              telescope.lsp_workspace_symbols({ query = query })
            end)
          end, opts("LSP: [W]orkspace [S]ymbols"))
        end
      })

    end
  },
}

