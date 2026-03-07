return {
  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "classic",
      delay = function (ctx)
        return 700
      end,
      icons = {
        group = (vim.g.fallback_icons_enabled and "+") or "",
        rules = false,
        separator = "󰌌",
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
