-- Add signs for DapUI.
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakPoint", })
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint", })
vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped", })

return {
  {
    "folke/tokyonight.nvim",
    enabled = vim.g.default_colorscheme == 'tokyonight',
    lazy = true,
    config = function ()
      require('tokyonight').setup({
        style = 'night',
        styles = {
          comments = {
            italic = false,
          },
          keywords = {
            italic = false,
            bold = true,
          },
          floats = 'transparent',
        },
        on_highlights = function (highlights, colors)
          -- Dap highlights.
          highlights.DapBreakPoint = { fg = colors.error, }
          highlights.DapLogPoint = { fg = colors.terminal.yellow_bright, }
          highlights.DapStopped = { fg = colors.fg, }
        end
      })
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
        pmenu = false,
        normal = false,
        normalfloat = true,
        whichkey = false,
        telescope = true,
        lazy = true,
      },
      error_lens = {
        text = true,
        symbol = false,
      },
    },
    config = function(_, opts)
      opts.on_highlights = function (colors, color)
        local groups = {
          LineNr = { fg = colors.base1 },
          diffAdded = { bg = "#e7eddb", fg = colors.git_add },
          diffRemoved = { bg = "#f8e2d9", fg = colors.git_delete },
            -- Dap highlights.
            DapBreakPoint = { bg = colors.base3, fg = colors.red, },
            DapLogPoint = { bg = colors.base3, fg = colors.yellow, },
            DapStopped = { bg = colors.base3, fg = colors.blue, },
        }
        return groups
      end
      require('solarized').setup(opts)
      vim.o.termguicolors = true
      vim.o.background = 'light'
    end,
  },
  {
    'Shatur/neovim-ayu',
    enabled = vim.g.default_colorscheme == 'ayu',
    lazy = true,
    priority = 1000,
    config = function ()
      local colors = require('ayu.colors')
      colors.generate(true) -- Pass `true` to enable mirage
      require('ayu').setup({
          overrides = {
            Comment = { fg = colors.comment },
            -- Dap highlights.
            DapBreakPoint = { fg = colors.red, },
            DapLogPoint = { fg = colors.yellow, },
            DapStopped = { fg = colors.entity, },
          }
      })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = vim.g.default_colorscheme == 'dawnfox',
    lazy = true,
    priority = 1000,
    config = function ()
      require('nightfox').setup({
        groups = {
          dawnfox = {
            diffAdded = { bg = "palette.sel0"},
            diffRemoved = { bg = "#ecd7d6"},
            MiniIndentscopeSymbol = { fg = "palette.magenta.dim"},
            -- Dap highlights.
            DapBreakPoint = { fg = "palette.red.dim", },
            DapLogPoint = { fg = "palette.yellow.dim", },
            DapStopped = { fg = "palette.blue.dim", },
          }
        },
      })
    end
  },
}
