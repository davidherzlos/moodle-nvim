-- Telescope for fuzzy finding almost anything.
return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  branch = 'master', -- branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    "neovim/nvim-lspconfig",
    "tsakirist/telescope-lazy.nvim",
    "folke/snacks.nvim",
    { 'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim" ,
      version = "^1.0.0",
    },
  },
  config = function()
    local utils = require("config.utils")
    local lga_actions = require("telescope-live-grep-args.actions")
    require("telescope").setup({
      defaults = {
        debounce = 100,
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          -- Ignore some patterns to speed up.
          '--glob=!node_modules',
          '--glob=!vendor',
          '--glob=!*.min.js',
          '--glob=!*.min.css',
        },
        file_ignore_patterns = {
          "node_modules",
          "vendor/",
          "%.git/",
          "%.cache/",
          "%.min%.css$",
          "%.min%.js$",
          "%.min.js$",
          "%-min.js$",
          "%.min.js.map$",
          "%.idea/",
          "%.vscode/",
          "nbproject/",
          "%.settings/",
          "node_modules/",
          "vendor/",
          "yui/build/",
          "%-coverage%.js$",
          "%.cache/",
          "%.phpunit%.result%.cache",
          "jsdoc/",
          "admin/tool/componentlibrary/docs/",
          "%.DS_Store",
          "%.phar$",
        },
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        cache_picker = {
          num_pickers = 10,
          limit_entries = 1000,
        },
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-l>"] = require("telescope.actions").select_default,
            ["<C-CR>"] = require("telescope.actions").select_default,
            ["<CR>"] = require("telescope.actions").select_default,
          },
        },
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            width = { padding = 12 },
            height = { padding = 3 },
            preview_width = 0.55,
          };
        },
        sorting_strategy = 'ascending',
        preview = {
          treesitter = false
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
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
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({})
        },
        live_grep_args = {
          auto_quoting = false, -- enable/disable auto-quoting
          mappings = { -- extend mappings
            i = {
              ["''"] = lga_actions.quote_prompt(),
            },
          },
        },
        fzf = {},
      }
    })

    local telescope = require("telescope.builtin")

    -- Enable telescope extensions if they are installed.
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("lazy")
    require("telescope").load_extension("live_grep_args")

    -- Custom pickers on this config.
    local live_multigrep = require("plugins.telescope.pickers.multigrep").live_multigrep
    local buffer_jump = require("plugins.telescope.pickers.buffer_jump").buffer_jump
    local live_grep_args = require('telescope').extensions.live_grep_args.live_grep_args
    local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

    -- Quick pick keymaps.
    vim.keymap.set('n', '<leader>qb', telescope.buffers, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>qh', telescope.help_tags, { desc = 'Help' })
    vim.keymap.set('n', '<leader>qk', telescope.keymaps, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>ql', telescope.resume, { desc = 'Resume last' })
    vim.keymap.set('n', '<leader>qp', telescope.pickers, { desc = 'Pickers' })
    vim.keymap.set('n', '<leader>qz', '<cmd>Telescope lazy<CR>', { desc = 'Lazy' })
    vim.keymap.set('n', '<leader>qj', buffer_jump, { desc = 'Jump in buffer' })
    vim.keymap.set('n', '<leader>qq', telescope.builtin, { desc = 'Open picker' })

    -- Language server Protocol.
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local opts = function(opts)
          opts.buffer = event.buf
          return opts
        end
        vim.keymap.set('n', '<leader>sd', function() telescope.lsp_definitions({ jump_type = 'never' }) end, opts({ desc = 'Definitions' }))
        vim.keymap.set('n', '<leader>si', telescope.lsp_implementations, opts({ desc = 'Implementations' }))
        vim.keymap.set('n', '<leader>sr', telescope.lsp_references, opts({ desc = 'References' }))
        vim.keymap.set('n', '<leader>rs', vim.lsp.buf.rename, opts({ desc = 'Rename symbol' }))
        vim.keymap.set({"n", "v", "s"}, '<leader>ra', vim.lsp.buf.code_action, opts({ desc = 'Code actions' }))
        vim.keymap.set('n', '<leader>ss', telescope.lsp_document_symbols, opts({ desc = 'Document symbols' }))
        vim.keymap.set('n', '<leader>sw', telescope.lsp_dynamic_workspace_symbols, opts({ desc = 'Workspace symbols' }))
      end
    })

    -- Some autocommands.
    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function(args)
        vim.wo.number = true
        vim.wo.wrap = false
      end,
    })
  end
}
