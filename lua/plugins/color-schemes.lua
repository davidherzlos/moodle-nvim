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
          highlights.NormalFloat = { bg = colors.bg, fg = colors.fg, }
          highlights.FloatBorder = { bg = colors.bg, fg = colors.border_highlight, }
          highlights.FloatTitle = { bg = colors.bg, fg = colors.fg, }

          -- MsgArea
          highlights.MsgArea = { bg = colors.bg_dark }

          -- Mini
          highlights.MiniFilesNormal= { bg = colors.bg }
          highlights.MiniFilesTitleFocused = { bg = colors.bg, fg = colors.yellow, } -- We may not need this one.

          -- Snacks
          highlights.SnacksPickerInputBorder = { bg = colors.none, fg = colors.yellow }
          highlights.SnacksPickerInputTitle = { bg = colors.bg_dark, fg = colors.yellow }
          highlights.SnacksPickerInputCursorLine = { bg = colors.none, fg = colors.fg }
          highlights.SnacksPickerListTitle = { bg = colors.bg_dark, fg = colors.border_highlight }
          highlights.SnacksPickerPreviewTitle = { bg = colors.bg_dark, fg = colors.border_highlight }


          -- Tabline
          highlights.TabLine = { bg = colors.bg }
          highlights.TabLineFill = { bg = colors.diff.change }

          -- Telescope
          highlights.TelescopeNormal = { bg = colors.bg, }
          highlights.TelescopeBorder = { bg = colors.bg, fg = colors.border_highlight, }
          highlights.TelescopePromptBorder = { bg = colors.bg, fg = colors.yellow, }
          highlights.TelescopePromptTitle = { bg = colors.bg_dark, fg = colors.yellow, }
          highlights.TelescopePreviewTitle = { bg = colors.bg_dark, fg = colors.border_highlight, }
          highlights.TelescopeResultsTitle = { bg = colors.bg_dark, fg = colors.border_highlight, }

          -- Treesitter context.
          highlights.TreesitterContext = { bg = colors.bg_dark }
          highlights.TreesitterContextBottom = { bg = colors.bg_dark }
          highlights.TreesitterContextLineNumber = { bg = colors.bg_dark, fg = colors.yellow }
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
      vim.g.everforest_enable_italic = 0
      vim.g.everforest_disable_italic_comment = 1
      vim.g.everforest_float_style = 'dim'

      if vim.g.default_colorscheme == 'everforest' then
        vim.api.nvim_create_autocmd('ColorScheme', {
          group = vim.api.nvim_create_augroup('custom_highlights_everforest', {}),
          pattern = 'everforest',
          callback = function()
            local config = vim.fn['everforest#get_configuration']()
            local palette = vim.fn['everforest#get_palette'](config.background, config.colors_override)
            local set_hl = vim.fn['everforest#highlight']

            -- Dap
            set_hl('DapBreakpoint', palette.red, palette.none)
            set_hl('DapLogPoint', palette.yellow, palette.none)
            set_hl('DapStopped', palette.blue, palette.none)

            -- Floats
            set_hl('NormalFloat', palette.fg, palette.bg0)
            set_hl('FloatBorder', palette.grey1, palette.bg0)
            set_hl('FloatTitle', palette.fg, palette.bg0)

            -- Git fugitive
            set_hl('diffAdded', palette.green, palette.bg_green)
            set_hl('diffRemoved', palette.red, palette.bg_red)

            -- MsgArea
            set_hl('MsgArea', palette.fg, palette.bg1)

            -- Mini
            set_hl('MiniFilesNormal', palette.fg, palette.bg0)

          -- Snacks
            set_hl('SnacksPickerInputBorder', palette.green, palette.none)
            set_hl('SnacksPickerInputTitle', palette.green, palette.bg_dim)
            set_hl('SnacksPickerPreviewTitle', palette.fg, palette.bg_dim)
            set_hl('SnacksPickerListTitle', palette.fg, palette.bg_dim)

            -- Telescope
            set_hl('TelescopePromptBorder', palette.green, palette.none)
            set_hl('TelescopePromptTitle', palette.green, palette.bg_dim)
            set_hl('TelescopePreviewTitle', palette.fg, palette.bg_dim)
            set_hl('TelescopeResultsTitle', palette.fg, palette.bg_dim)

          -- Treesitter context.
            set_hl('TreesitterContext', palette.none, palette.bg_dim)
            set_hl('TreesitterContextBottom', palette.none, palette.bg_dim)
            set_hl('TreesitterContextLineNumber', palette.none, palette.bg_dim)

          -- Treesitter context.
            set_hl('WhichKeyNormal', palette.none, palette.bg_dim)
          end
        })
      end
    end
  },
}
