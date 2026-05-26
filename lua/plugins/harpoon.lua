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
      vim.keymap.set("n", "<leader>bh", function() harpoon:list():select(1) end, { desc = "Bookmark 1" })
      vim.keymap.set("n", "<leader>bj", function() harpoon:list():select(2) end, { desc = "Bookmark 2" })
      vim.keymap.set("n", "<leader>bk", function() harpoon:list():select(3) end, { desc = "Bookmark 3" })
      vim.keymap.set("n", "<leader>bl", function() harpoon:list():select(4) end, { desc = "Bookmark 4" })
      vim.keymap.set("n", "<leader>ba", function() harpoon:list():add() end, { desc = "Add to bookmarks" })
      vim.keymap.set("n", "<leader>bb", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Show bookmarks" })
      end
      }
    }

