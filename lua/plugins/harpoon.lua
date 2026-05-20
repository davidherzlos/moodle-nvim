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
      vim.keymap.set("n", "<leader>nh", function() harpoon:list():select(1) end, { desc = "Show item 1" })
      vim.keymap.set("n", "<leader>nj", function() harpoon:list():select(2) end, { desc = "Show item 2" })
      vim.keymap.set("n", "<leader>nk", function() harpoon:list():select(3) end, { desc = "Show item 3" })
      vim.keymap.set("n", "<leader>nl", function() harpoon:list():select(4) end, { desc = "Show item 4" })
      vim.keymap.set("n", "<leader>na", function() harpoon:list():add() end, { desc = "Add to menu" })
      vim.keymap.set("n", "<leader>nm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Menu" })
      end
      }
    }

