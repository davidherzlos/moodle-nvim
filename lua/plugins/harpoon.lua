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
      vim.keymap.set("n", "<leader>nh", function() harpoon:list():select(1) end, { desc = "Nav to h (1)" })
      vim.keymap.set("n", "<leader>nj", function() harpoon:list():select(2) end, { desc = "Nav to j (2)" })
      vim.keymap.set("n", "<leader>nk", function() harpoon:list():select(3) end, { desc = "Nav to k (3)" })
      vim.keymap.set("n", "<leader>nl", function() harpoon:list():select(4) end, { desc = "Nav to l (4)" })
      vim.keymap.set("n", "<leader>na", function() harpoon:list():add() end, { desc = "Add to nav list" })
      vim.keymap.set("n", "<leader>nn", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Nav list" })
      end
      }
    }

