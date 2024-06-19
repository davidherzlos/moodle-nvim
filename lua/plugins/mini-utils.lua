return {
  -- This module defined all related utilities from mini plugins.
  {
    'echasnovski/mini.nvim',
    version = false,

    config = function()

      -- Mini file manager.
      require('mini.files').setup()
      vim.keymap.set("n", "<leader>fm", ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>", { desc = "[M]ini [F]iles Open" })
      vim.keymap.set("n", "<esc>", ":lua MiniFiles.close()<CR>", { desc = "[M]ini [F]iles Close" })
      vim.keymap.set("n", "<leader>FM", ":lua MiniFiles.open()<CR>", { desc = "[M]ini [F]iles Open Cwd" } )

      -- Animated indent scope line.
      require('mini.indentscope').setup({
        options = {
          border = 'top',
          try_as_border = true,
        },
      })

      -- Automatic pairing characters.
      require('mini.pairs').setup({})

    end

  },
}
