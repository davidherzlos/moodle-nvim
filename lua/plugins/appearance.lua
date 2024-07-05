local function highlight_telescope(hl, c)
  local prompt = c.bg
  hl.TelescopeNormal = {
    bg = 'none',
    fg = c.fg,
  }
  hl.TelescopeBorder = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
end
local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavor = 'mocha',
      transparent_background = true,
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      no_italic = true, -- Force no italic
      no_bold = true, -- Force no bold
      no_underline = false, -- Force no underline
      -- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      --     comments = { "italic" }, -- Change the style of comments
      --     conditionals = { "italic" },
      --     loops = {},
      --     functions = {},
      --     keywords = {},
      --     strings = {},
      --     variables = {},
      --     numbers = {},
      --     booleans = {},
      --     properties = {},
      --     types = {},
      --     operators = {},
      --     -- miscs = {}, -- Uncomment to turn off hard-coded styles
      -- },
      color_overrides = {
        mocha = {
          ['base'] = "#1a1b26",
          ['overlay0'] = '#565f89', --comments
          --['overlay1'] = '#ff00e6',
          -- ['overlay2'] = '#3f4bf3',
          --['surface0'] = '#2b2b42', -- Current line and lualine.
          ['surface1'] = '#434a66', --line numbers
          -- ['surface2'] = '#e5ff00',
        }
      },
      -- custom_highlights = {},
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

  end
}

local tokyonight = {
  --"zeioth/tokyonight.nvim",
  "folke/tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = {
    style = 'night',
    transparent = true,
    styles = {
      sidebars = 'transparent',
      floats = 'transparent'
    },
    dime_inactive = false,
    on_highlights = function(hl, c)
      highlight_telescope(hl, c)
    end,
  },
}

return tokyonight

