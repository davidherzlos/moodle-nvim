return {
  {
    'saghen/blink.cmp',
    enabled = false,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",                  -- Snippets expansion engine.
        version = "v2.*",
        build = "make install_jsregexp"
      },
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    opts_extend = { "sources.default" },
    config = function ()
      require('blink.cmp').setup({
        keymap = { preset = 'default' },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'mono'
        },
        snippets = {
          expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
          active = function(filter)
            if filter and filter.direction then
              return require('luasnip').jumpable(filter.direction)
            end
            return require('luasnip').in_snippet()
          end,
          jump = function(direction) require('luasnip').jump(direction) end,
        },
        sources = {
          default = { 'lsp', 'path', 'luasnip', 'buffer' },
        },
      })

      local luasnip = require('luasnip')
      vim.keymap.set({ "i", "s", "n" }, "<M-p>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { expr = true, silent = true })
      vim.keymap.set({ "i", "s", "n" }, "<M-n>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { expr = true, silent = true })
    end
  }
}
