-- Telescope for fuzzy finding almost anything.
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
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
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end
    },
  },
  config = function()
    local utils = require("config.utils")
    require("telescope").setup({
      defaults = {
        cache_picker = {
          num_pickers = 10,
          limit_entries = 1000,
        },
        mappings = {
          i = {
            ["<M-j>"] = require("telescope.actions").move_selection_next,
            ["<M-k>"] = require("telescope.actions").move_selection_previous,
            ["<CR>"] = require("telescope.actions").select_default,
            ["qq"] = require("telescope.actions").close,
          },
          n = {
            ["q"] = require("telescope.actions").close,
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
      },
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
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({})
        },
        fzf = {},
      }
    })

    local telescope = require("telescope.builtin")

    -- Enable telescope extensions if they are installed.
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("lazy")

    -- Custom pickers on this config.
    local live_multigrep = require("plugins.telescope.pickers.multigrep").live_multigrep
    local buffer_jump = require("plugins.telescope.pickers.buffer_jump").buffer_jump

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
    vim.keymap.set('n', '<leader>fo', telescope.oldfiles, { desc = 'Telescoope: files (old)' })
    vim.keymap.set('n', '<leader>ip', '<cmd>Telescope lazy<CR>', { desc = 'Telescoope: files (old)' })

    -- Grep.
    vim.keymap.set('n', '<leader>gg', live_multigrep, { desc = 'Telescope: grep' })
    vim.keymap.set('n', '<leader>g.', function() live_multigrep({ cwd = utils.git_root() }) end, { desc = 'Telescope: grep(current)'})
    vim.keymap.set('n', '<leader>gc', function() live_multigrep({ cwd = utils.config_path() }) end, { desc = 'Telescope: grep(config)'})
    vim.keymap.set('n', '<leader>gp', function() live_multigrep({ cwd = utils.plugins_path() }) end, { desc = 'Telescope: grep(plugins)'})
    vim.keymap.set('n', '<leader>gw', telescope.grep_string, { desc = 'Telescope: grep(word)' })
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
