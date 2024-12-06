-- TODO: Refactor this functions to use correctly the APIS.
-- Customize signs for Debugging.
vim.api.nvim_set_hl(0, 'DapBreakPoint', { ctermbg = 0, fg = '#db4b4b', bg = '#2c0f0f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#e0af68', bg = '#2d2315' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#1abc9c', bg = '#05261f' })
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakPoint", linehl = "DapBreakPoint", numhl = "DapBreakPoint"})
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint"})
vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped"})

return {
  {
    "folke/tokyonight.nvim",
    enabled = vim.g.default_colorscheme == 'tokyonight',
    lazy = true,
    priority = 1000,
    config = function ()
      require('tokyonight').setup({
        style = 'night',
        transparent = true,
        styles = {
          floats = "transparent",
          comments = {
            italic = false,
          },
          keywords = {
            italic = false,
            bold = true,
          },
        },
        dime_inactive = false,
        on_colors = function (colors)
        end,
        on_highlights = function(hl, c)
          local prompt = c.bg
          hl.TelescopeNormal = {
            bg = c.bg,
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
          hl.CursorLine = {
            bg = c.bg
          }
          hl.MiniIndentscopeSymbol = {
            fg = "#515a81"
          }
        end,
      })
      -- Customize highlights for GitSigns.
      vim.api.nvim_set_hl(0, 'GitSignsAddLn', { bg = '#1a282e' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { bg = '#1a282e' })
      vim.api.nvim_set_hl(0, 'GitSignsStagedAddLn', { bg = '#132a40' })
      vim.api.nvim_set_hl(0, 'GitSignsStagedChangeLn', { bg = '#132a40' })
      vim.api.nvim_set_hl(0, 'GitSignsDeleteVirtLn', { bg = '#301014' })
      vim.api.nvim_set_hl(0, 'GitSignsStagedChangedeleteLn', { bg = '#301026' })
    end
  },
  {
    'maxmx03/solarized.nvim',
    enabled = vim.g.default_colorscheme == 'solarized',
    lazy = true,
    priority = 1000,
    opts = {
      transparent = {
        enabled = true,
        whichkey = false,
      },
    },
    config = function(_, opts)
      opts.on_highlights = function (colors, color)
        ---@type solarized.highlights
        local groups = {
            GitSignsStagedAddLn = { fg = colors.cyan, bg = colors.base2 },
            GitSignsStagedChangeLn = { fg = colors.yellow, bg = colors.base2 },
            GitSignsStagedChangedeleteLn = { fg = colors.red, bg = colors.base2 }
        }
        return groups
      end
      require('solarized').setup(opts)
      vim.o.termguicolors = true
      vim.o.background = 'light'
    end,
  },
  --[[
base4............................... = "#fbf3db" 
mix_yellow.......................... = "#364725" 
diag_error.......................... = "#DC322F" 
git_delete.......................... = "#DC322F" 
git_modify.......................... = "#B58900" 
base2............................... = "#eee8d5"  background highlight (light)
base00.............................. = "#657B83" foreground (light)
base3............................... = "#fdf6e3" background (light)
mix_violet.......................... = "#204060" 
violet.............................. = "#6C71C4" 
orange.............................. = "#CB4B16" 
red................................. = "#DC322F" 
base03.............................. = "#002B36" background (dark)
base02.............................. = "#073642" background highlight (dark)
mix_cyan............................ = "#0C4E53" 
mix_magenta......................... = "#3F2E4C" 
magenta............................. = "#D33682" 
diag_ok............................. = "#859900" 
mix_base1........................... = "#2C4E56" 
mix_orange.......................... = "#3C342C" 
cyan................................ = "#2AA198" 
yellow.............................. = "#B58900" 
diag_hint........................... = "#268BD2" 
mix_red............................. = "#422D33" 
mix_base01.......................... = "#CCCDC2" 
mix_green........................... = "#274C25" 
green............................... = "#859900" 
git_add............................. = "#268BD2" 
diag_info........................... = "#268BD2" 
base01.............................. = "#586E75" comments (dark)
base1............................... = "#93A1A1" comments (light)
base0............................... = "#839496" foreground (dark)
diag_warning........................ = "#B58900" 
base04.............................. = "#002731" 
blue................................ = "#268BD2" 
mix_blue............................ = "#0B4764" 
    ]]--
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = vim.g.default_colorscheme == 'rose-pine',
    lazy = true,
    config = function ()
      require('rose-pine').setup({
        variant = "dawn",
        dark_variant = "dawn",
        styles = {
          italic = false,
          transparent = true,
        }
      })
    end
  }
}
