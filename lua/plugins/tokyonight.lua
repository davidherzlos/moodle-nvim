return {
  -- Tokyo night theme.
  {
    "folke/tokyonight.nvim", 
    lazy = false, 
    priority = 1000,
    -- This little callback enables the colorscheme.
    config = function()
      vim.cmd.colorscheme "tokyonight-night"
    end,
    opts = {}
  }
}

