return {
  -- I like a minimal but elegant status line.
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      -- Add a simple but functional status line.
      local status_line = require('mini.statusline')
      status_line.setup(
        {
          use_icons = vim.g.have_nerd_font,
          set_vim_settings = false,
        })
      status_line.section_location = function()
        return '%2l:%-2v'
      end

      -- Add a cool util to explore and manage files.
      require('mini.files').setup()
      vim.keymap.set("n", "<leader>FM", ":lua MiniFiles.open()<CR>", { desc = "[M]ini [F]iles" } )
      vim.keymap.set("n", "<leader>fm", ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>", { desc = "[M]ini [F]iles on Path" })

      -- Add an animated indent scope line.
      require('mini.indentscope').setup({
        options = {
          border = 'top',
          try_as_border = true,
        },
      })
    end
  },
}
