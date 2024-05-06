return {
  -- Tokyo night theme.
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    -- This little callback enables the colorscheme.
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl, c)
          local kitty = "#1a1b26"
          local blue = "#8fa6dc"
          hl.TelescopeNormal = {
            bg = kitty,
          }
          hl.TelescopeBorder = {
            bg = kitty,
            fg = blue,
          }
          hl.TelescopePromptBorder = {
            bg = kitty,
            fg = blue,
          }
          hl.TelescopePromptTitle = {
            fg = blue,
          }
          hl.TelescopePreviewTitle = {
            fg = blue,
          }
          hl.TelescopeResultsTitle = {
            fg = blue,
          }
        end,
      })
      vim.cmd.colorscheme "tokyonight-night"
    end,
    opts = {}
  }
}

