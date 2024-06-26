return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        transparent_background = true,
        default_integrations = true,
        integrations = {
          notifier = true,
          dap = true,
          dap_ui = true,
          which_key = true,
          treesitter = true,
          treesitter_context = true,
          gitsigns = true,
          harpoon = true,
          leap = true,
          mason = true,
          cmp = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
          mini = {
            enabled = true,
            indentscope_color = "surface1",
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
          treesitter_context = true,
            underlines = {
              errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
            inlay_hints = {
                background = true,
            },
          },
        }
      })
      vim.cmd.colorscheme "catppuccin"

    end

  },
}

