return {
  {
    "folke/tokyonight.nvim",
    enabled = vim.g.default_colorscheme == 'tokyonight',
    lazy = true,
    config = function ()
      require('tokyonight').setup({
        transparent = false,
        style = 'night',
        styles = {
          comments = {
            italic = false,
          },
          keywords = {
            italic = false,
            bold = true,
          },
        },
        on_highlights = function (highlights, colors)

          -- Blink-cmp
          highlights.BlinkCmpMenu = { bg = colors.bg_dark }
          highlights.BlinkCmpDoc = { bg = colors.bg_dark }
          highlights.BlinkCmpScrollBarGutter = { bg = colors.bg_dark }
          highlights.BlinkCmpDocSeparator = { bg = colors.bg_dark, fg = colors.bg_dark }
          highlights.BlinkCmpSignatureHelp = { bg = colors.bg_dark }
          highlights.BlinkCmpSignatureHelpBorder = { bg = colors.bg_dark, fg = colors.bg_dark }

         -- BetterQFList
          highlights.BqfPreviewFloat = { bg = colors.bg_dark1, fg = colors.bg_dark1 }
          highlights.BqfPreviewBorder = { bg = colors.bg_dark1, fg = colors.bg_dark1 }
          highlights.BqfPreviewTitle = { bg = colors.bg_dark1, fg = colors.bg_dark1 }
          highlights.BqfPreviewCursorLine = { bg = colors.bg_dark1 }

          -- Dap
          highlights.DapBreakpoint = { fg = colors.red }
          highlights.DapLogPoint = { fg = colors.yellow }
          highlights.DapStopped = { fg = colors.blue }

          -- Floats
          highlights.NormalFloat = { bg = colors.bg_dark, fg = colors.fg, }
          highlights.FloatBorder = { bg = colors.bg_dark, fg = colors.bg_dark, }
          highlights.FloatTitle = { bg = colors.bg_dark, fg = colors.fg, }

          -- MsgArea
          highlights.MsgArea = { bg = colors.bg_dark, }

          -- Mini
          highlights.MiniFilesTitleFocused = { bg = colors.bg_dark, fg = colors.fg, }

          -- Tabline
          highlights.TabLine = { bg = colors.bg_dark }
          highlights.TabLineFill = { bg = colors.bg_dark1 }

          -- Telescope
          highlights.TelescopeNormal = { bg = colors.bg_dark, fg = colors.fg_dark, }
          highlights.TelescopeBorder = { bg = colors.bg_dark, fg = colors.bg_dark, }
          highlights.TelescopePromptNormal = { bg = colors.bg_dark, fg = colors.fg_dark, }
          highlights.TelescopePromptBorder = { bg = colors.bg_dark, fg = colors.bg_dark, }
          highlights.TelescopePromptTitle = { bg = colors.bg_dark, fg = colors.fg_dark, }
          highlights.TelescopePreviewTitle = { bg = colors.bg_dark, fg = colors.bg_dark, }
          highlights.TelescopeResultsTitle = { bg = colors.bg_dark, fg = colors.bg_dark, }

          -- Treesitter context.
          highlights.TreesitterContext = { bg = colors.bg_dark }
          highlights.TreesitterContextBottom = { bg = colors.bg_dark }
          highlights.TreesitterContextLineNumber = { bg = colors.bg_dark, fg = colors.blue }
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
          -- Misc.
          LineNr = { fg = colors.base1 },

          -- Git fugitive.
          diffAdded = { bg = "#e7eddb", fg = colors.git_add },
          diffRemoved = { bg = "#f8e2d9", fg = colors.git_delete },

          -- Dap highlights.
          DapBreakpoint = { fg = colors.red },
          DapLogPoint = { fg = colors.yellow },
          DapStopped = { fg = colors.blue },

          -- Treesitter context.
          TreesitterContext = { bg = colors.base2 },
          TreesitterContextBottom = { bg = colors.base2  },
          TreesitterContextLineNumber = { bg = colors.base2, fg = colors.cyan },

          -- Tabline
          TabLine = { bg = colors.mix_base01  },
          TabLineSel = { bg = colors.base1, fg = colors.base3 },
          TabLineFill = { bg = colors.base4 },
        }
        return groups
      end
      require('solarized').setup(opts)
      vim.o.termguicolors = true

    end,
  },
  {
    'sainnhe/gruvbox-material',
    enabled = vim.g.default_colorscheme == 'gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = false
      vim.g.gruvbox_material_disable_italic_comment = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_background = 'soft'
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('custom_highlights_gruvboxmaterial', {}),
        pattern = 'gruvbox-material',
        callback = function()
          local config = vim.fn['gruvbox_material#get_configuration']()
          local palette = vim.fn['gruvbox_material#get_palette'](config.background, config.foreground, config.colors_override)
          local set_hl = vim.fn['gruvbox_material#highlight']

          -- Float highlights.
          set_hl('NormalFloat', palette.none, palette.none) 
          set_hl('FloatBorder', palette.grey0, palette.none) 
          set_hl('FloatTitle', palette.none, palette.none) 

          -- Telescope highlights.
          set_hl('TelescopeBorder', palette.grey0, palette.none) 

          -- Git highlights.
          set_hl('diffAdded', palette.none, palette.bg_visual_green) 
          set_hl('diffRemoved', palette.none, palette.bg_visual_red) 
          set_hl('CurrentWord', palette.none, palette.bg_visual_yellow)

          -- Dap highlights.
          set_hl('DapBreakpoint', palette.red, palette.none, 'bold')
          set_hl('DapLogPoint', palette.bg_yellow, palette.none, 'bold')
          set_hl('DapStopped', palette.bg_green, palette.none, 'bold')

          -- Treesitter context.
          set_hl('TreesitterContext', palette.none, palette.bg_visual_yellow)
          set_hl('TreesitterContextBottom', palette.none, palette.bg_visual_yellow)
          set_hl('TreesitterContextLineNumber', palette.yellow, palette.bg_visual_yellow, 'bold')
        end
      })
    end
  },
  {
    'sainnhe/everforest',
    enabled = vim.g.default_colorscheme == 'everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'medium'
      vim.g.everforest_better_performance = 1 
      vim.g.everforest_enable_italic = true
      vim.g.everforest_float_style = 'none'
    end
  },
}
