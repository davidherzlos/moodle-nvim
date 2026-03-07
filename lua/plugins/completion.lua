return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',        -- VSCode generic snippets.
      'ManuelGil/vscode-moodle-snippets',    -- VSCode snippets for Moodle Development.
      {
        "L3MON4D3/LuaSnip",                  -- Snippets expansion engine.
        version = "v2.*",
        build = "make install_jsregexp"
      },
    },
    -- use a release tag to download pre-built binaries
    version = '1.*',
    config = function ()
      local luasnip = require("luasnip")
      luasnip.setup({
        history = true, -- History is deprecated
        delete_check_events = "TextChanged,InsertLeave",
      })
      require('blink-cmp').setup({
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
          -- set to 'none' to disable the 'default' preset
          preset = 'none',
          ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
          ['<C-k>'] = {
            function(cmp)
              if cmp.is_visible() then
                local items = cmp.get_items()
                if #items == 1 then
                  return true  -- Block cycling, keep item selected
                end
              end
            end,
            'select_prev'
          },
          ['<C-j>'] = {
            function(cmp)
              if cmp.is_visible() then
                local items = cmp.get_items()
                if #items == 1 then
                  return true  -- Block cycling, keep item selected
                end
              end
            end,
            'select_next'
          },
          ['<C-l>'] = { 'accept', 'fallback' },
          ['<C-CR>'] = { 'accept', 'fallback' },
          ['<CR>'] = { 'accept', 'fallback' },
          ['<C-f>'] = {
            function()
              if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                return true
              end
              return true
            end,
            'fallback'
          },
          ['<C-b>'] = {
            function()
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
                return true
              end
              return true
            end,
            'fallback'
          },
        },
        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          nerd_font_variant = 'mono'
        },
        snippets = { preset = 'luasnip' },
        completion = {
          documentation = {
            auto_show = true,
            window = {
              min_width = 20,
              max_width = 40,
              max_height = 80,
            },
          },
          menu = {
            draw = {
              align_to = 'kind_icon',
              columns = {
                { "kind_icon", "label", "kind", gap = 2 },
              },
              padding = { 1, 1 },
              snippet_indicator = '',
            },
          },
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
          per_filetype = {
            sql = { 'snippets', 'dadbod', 'buffer' },
          },
          providers = {
            dadbod = { name = 'Dadbod', module = "vim_dadbod_completion.blink" },
            snippets = {
              opts = {
                friendly_snippets = true, -- default
              }
            }
          }
        },
        -- Experimental signature help support
        signature = {
          enabled = true,
          trigger = {
            show_on_insert = true,
          },
          window = {
            min_width = 1,
            max_width = 100,
            max_height = 10,
            border = 'single',
            treesitter_highlighting = true,
            show_documentation = false,
          },
        }
      })

      -- Lazy load snipets. 
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./lua/config/snippets" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.local/share/nvim/lazy/vscode-moodle-snippets" } })
    end
  },
}
