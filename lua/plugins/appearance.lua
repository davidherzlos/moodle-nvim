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
      hl.CursorLine = {
        bg = c.bg
      }
      hl.MiniIndentscopeSymbol = {
        fg = "#515a81"
      }
    end,
  },
}

return tokyonight

