return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      -- Define custom keymaps.
      vim.keymap.set("n", "<leader>gh", function() harpoon:list():select(1) end, { desc = "Harpoon: Buffer 1" })
      vim.keymap.set("n", "<leader>gj", function() harpoon:list():select(2) end, { desc = "Harpoon: Buffer 2" })
      vim.keymap.set("n", "<leader>gk", function() harpoon:list():select(3) end, { desc = "Harpoon: Buffer 3" })
      vim.keymap.set("n", "<leader>gl", function() harpoon:list():select(4) end, { desc = "Harpoon: Buffer 4" })
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: add"})
      vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: list" })
      end
      }
    }

