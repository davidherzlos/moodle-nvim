return {
  {
    'hrsh7th/nvim-cmp',      -- Completion engine.
    dependencies = {
      'rafamadriz/friendly-snippets', -- VSCode snippets.
      'saadparwaiz1/cmp_luasnip', -- LuaSnip completion source for nvim-cmp.
      'L3MON4D3/LuaSnip',      -- Snippets expansion engine.
      'hrsh7th/cmp-nvim-lsp',  -- Completion source for builting lsp's.
    },

    -- 'neovim/nvim-lspconfig', --tc
    -- 'hrsh7th/cmp-buffer',    --tc
    -- 'hrsh7th/cmp-path',      --tc
    -- 'hrsh7th/cmp-cmdline',   --tc
    config = function()
      local cmp = require'cmp'

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'luasnip' }, -- For luasnip users.
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline({ '/', '?' }, {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = 'buffer' }
      --   }
      -- })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' }
      --   }),
      --   matching = { disallow_symbol_nonprefix_matching = false }
      -- })

      -- Broadcast capabilities for each lsp we have installed.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Bash LSP.
      require('lspconfig').bashls.setup {
        capabilities = capabilities
      }

      -- Lua LSP.
      require('lspconfig').lua_ls.setup {
        capabilities = capabilities
      }

      -- PHP LSP.
      require('lspconfig').intelephense.setup {
        capabilities = capabilities
      }
    end
  },
}
