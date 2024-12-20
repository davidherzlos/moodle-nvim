return {
  {
    'hrsh7th/nvim-cmp',                      -- Completion engine.
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    dependencies = {
      'rafamadriz/friendly-snippets',        -- VSCode generic snippets.
      'ManuelGil/vscode-moodle-snippets',    -- VSCode snippets for Moodle Development.
      'saadparwaiz1/cmp_luasnip',            -- LuaSnip completion source for nvim-cmp.
      {
        "L3MON4D3/LuaSnip",                  -- Snippets expansion engine.
        version = "v2.*",
	build = "make install_jsregexp"
      },
      'doxnit/cmp-luasnip-choice',           -- Autochoice completion node.
      'hrsh7th/cmp-nvim-lsp',                -- Completion source for builting lsp's.
      'onsails/lspkind.nvim',                -- Some pretty icons for lsp completions.
      "folke/lazydev.nvim",
    },

    -- TODO: Review these potential sources for completions:
    -- 'neovim/nvim-lspconfig', 'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-path',
    -- 'hrsh7th/cmp-cmdline',

    config = function()
      -- NOTE: These are convenient options for the menu, but they need to be tested.
      vim.opt.completeopt = { "menu", "menuone", "preview", "noselect" }

      -- Require some variables for further configuration.
      local cmp = require'cmp'
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')
      luasnip.setup({ history = true }) -- NOTE: This option is deprecated, but it is useful for going back to child snippets.
      lspkind.init()

      cmp.setup({

        -- Configure some icons to be shown on the completion list.
        formatting = {
          format = lspkind.cmp_format({
            preset = 'codicons', -- VsCode like icon.
            -- These are some custom icon overridings.
            symbol_map = {
               Text = "󰉿",
               Function = "󰡱",
               Constructor = "󰒕",
               Field = "󰜢",
               Variable = "󱕂",
               Property = "󰜢",
               Enum = "",
               Snippet = "",
               File = "",
               Folder = "󰉋",
               EnumMember = "",
               Constant = "󰏿",
               Struct = "󰙅",
               Event = "",
               Operator = "󰆕",
               TypeParameter = "",
            },
            mode = 'symbol_text',
            maxwidth = 35,
            ellipsis_char = '...',
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default

          })
        },

        -- Configure snippet expansion behaviour for nvim-cmp.
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Define some UI options.
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Define some mappings to interact with the completion list.
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-k>'] = cmp.mapping(cmp.mapping.confirm({ selected = false }), { "i", "c" }),
          ['<C-i>'] = cmp.mapping.abort(),
        }),

        -- Tell nvim-cmp the sources for the completion list.
        sources = cmp.config.sources(
          {
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
            { name = 'vim-dadbod-completion' }
          },
          {
            { name = 'buffer' }
          }
        )
      })

      -- Configure luasnip for jumping around the confirmed snippets.
      vim.keymap.set({ "i", "s", "n" }, "<C-j>", function() if luasnip.jumpable(-1) then luasnip.jump(-1) end end, { expr = true, silent = true })
      vim.keymap.set({ "i", "s", "n" }, "<C-l>", function() if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end end, { expr = true, silent = true })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('lspconfig').bashls.setup {
        capabilities = capabilities
      }
      require('lspconfig').lua_ls.setup {
        capabilities = capabilities
      }
      require('lspconfig').intelephense.setup {
        capabilities = capabilities
      }
      require('lspconfig').biome.setup {
        capabilities = capabilities,
        preferences = {
          disableSuggestions = false
        },
      }
      require('lspconfig').ts_ls.setup {
        capabilities = capabilities,
        preferences = {
          disableSuggestions = false
        },
      }

      -- Finally load some generic and Moodle specific vscode snippets packages.
      require("luasnip.loaders.from_vscode").lazy_load()

    end
  },
}
