-- TODO: Refactor this functions to use correctly the APIS.
local function add_signs_config()
  -- Configure editor signs and virtual text behavior for diagnostic messages.
  vim.diagnostic.config{
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " 󰞏",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
        [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      }
    },
  }
end

local function tweak_highlights()
  -- Customize signs for Debugging.
  vim.api.nvim_set_hl(0, 'DapBreakPoint', { ctermbg = 0, fg = '#db4b4b', bg = '#2c0f0f' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#e0af68', bg = '#2d2315' })
  vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#1abc9c', bg = '#05261f' })
  vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakPoint", linehl = "DapBreakPoint", numhl = "DapBreakPoint"})
  vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint"})
  vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped"})

  -- Gitsigns highlights
  vim.api.nvim_set_hl(0, 'GitSignsAddLn', { bg = '#1a282e' })
  vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { bg = '#1a282e' })
  vim.api.nvim_set_hl(0, 'GitSignsStagedAddLn', { bg = '#132a40' })
  vim.api.nvim_set_hl(0, 'GitSignsStagedChangeLn', { bg = '#132a40' })
  vim.api.nvim_set_hl(0, 'GitSignsDeleteVirtLn', { bg = '#301014' })
  vim.api.nvim_set_hl(0, 'GitSignsStagedChangedeleteLn', { bg = '#301026' })
end

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function ()
      require('tokyonight').setup({
        transparent = true,
        styles = {
          floats = "transparent",
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
      add_signs_config()
      tweak_highlights()
    end
  },
  {
    'maxmx03/solarized.nvim',
    priority = 1000,
    opts = {
      transparent = {
        enabled = true,
        whichkey = false,
      },
    },
    config = function(_, opts)
      vim.o.termguicolors = true
      vim.o.background = 'light'
      require('solarized').setup(opts)
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
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
