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

      -- Use Telescope as the ui for the list.
      local conf = require("telescope.config").values

      -- Define custom keymaps.
      vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end, { noremap = true, desc = "Harpoon: Pin"})
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: list" })
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon: Buffer 1" })
      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { noremap = true, desc = "Harpoon: Buffer 2" })
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Harpoon: Buffer 3" })
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Harpoon: Buffer 4" })
      end
      }
    }

