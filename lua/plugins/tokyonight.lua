return {
  -- Tokyo night theme.
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    -- This little callback enables the colorscheme.
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl)
          local kitty = "#1a1b26"
          local blue = "#0db9d7"
          local yellow = "#e0af68"
          hl.TelescopeNormal = {
            bg = kitty,
          }
          hl.TelescopeBorder = {
            bg = kitty,
            fg = blue,
          }
          hl.TelescopePromptBorder = {
            bg = kitty,
            fg = yellow,
          }
          hl.TelescopePromptTitle = {
            fg = blue,
          }
        end,
      })
      vim.cmd.colorscheme "tokyonight-night"
    end,
    opts = {}
  }
}

