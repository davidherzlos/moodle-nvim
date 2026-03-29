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

    -- Regular Keymaps.
    vim.keymap.set('n', '<leader>ss', telescope.builtin, { desc = 'Telescope: open' })
    vim.keymap.set('n', '<leader>kk', telescope.keymaps, { desc = 'Telescope: keymaps' })
    vim.keymap.set('n', '<leader>ll', telescope.resume, { desc = 'Telescope: last' })
    vim.keymap.set('n', '<leader>pp', telescope.pickers, { desc = 'Telescope: pickers' })
    vim.keymap.set('n', '<leader>hh', telescope.help_tags, { desc = 'Telescope: help' })
    vim.keymap.set('n', '<leader>bb', telescope.buffers, { desc = 'Telescope: buffers' })

    -- Files.
    vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope: files' })
    vim.keymap.set('n', '<leader>f.', function() telescope.find_files({ search_dirs = { utils.git_root() } }) end, { desc = 'Telescope: files (current)'})
    vim.keymap.set('n', '<leader>fc', function() telescope.find_files({ cwd = utils.config_path() }) end, { desc = 'Telescope: files (config)'})
    vim.keymap.set('n', '<leader>fp', function() telescope.find_files({ cwd = utils.plugins_path() }) end, { desc = 'Telescope: files (plugins)'})
    vim.keymap.set('n', '<leader>fo', telescope.oldfiles, { desc = 'Telescope: files (old)' })
    vim.keymap.set('n', '<leader>ip', '<cmd>Telescope lazy<CR>', { desc = 'Telescope: inspect plugins' })

    -- Grep.
    vim.keymap.set('n', '<leader>gg', function() live_grep_args() end, { desc = 'Telescope: grep' })
    vim.keymap.set('n', '<leader>g.', function() live_grep_args({ cwd = utils.git_root() }) end, { desc = 'Telescope: grep(currentdir)'})
    vim.keymap.set('n', '<leader>gc', function() live_grep_args({ cwd = utils.config_path() }) end, { desc = 'Telescope: grep(config)'})
    vim.keymap.set('n', '<leader>gp', function() live_grep_args({ cwd = utils.plugins_path() }) end, { desc = 'Telescope: grep(plugins)'})
    vim.keymap.set('n', '<leader>gw', function() live_grep_args_shortcuts.grep_word_under_cursor() end, { desc = 'Telescope: grep(word:word)'})
    vim.keymap.set('n', '<leader><leader>', buffer_jump, { desc = 'Telescope: jump on buffer' })

    -- Language server Protocol.
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local opts = function(opts)
          opts.buffer = event.buf
          return opts
        end
        vim.keymap.set('n', '<leader>sd', function() telescope.lsp_definitions({ jump_type = 'never' }) end, opts({ desc = 'Telescope: lsp definitions' }))
        vim.keymap.set('n', '<leader>si', telescope.lsp_implementations, opts({ desc = 'Telescope: lsp implementations' }))
        vim.keymap.set('n', '<leader>sr', telescope.lsp_references, opts({ desc = 'Telescope: lsp references' }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts({ desc = 'Telescope: lsp rename symbol' }))
        vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts({ desc = 'Telescope: lsp doc symbols' }))
        vim.keymap.set('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, opts({ desc = 'Telescope: lsp workspace symbols' }))
        vim.keymap.set({"n", "v", "s"}, '<leader>ca', vim.lsp.buf.code_action, opts({ desc = 'Telescope: code action' }))
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
