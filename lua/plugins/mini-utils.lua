return {
  -- This module defined all related utilities from mini plugins.
  {
    'echasnovski/mini.nvim',
    version = false,

    config = function()

      -- Mini file manager.
      require('mini.files').setup()

      -- Open it from the current buffer.
      vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>", { noremap = true, silent = true, desc = "Minifiles: [File] [M]anager open local" })

      -- Animated indent scope line.
      require('mini.indentscope').setup({
        draw = {
          delay = 500,
        },
        options = {
          border = 'top',
          try_as_border = true,
        },
      })

      -- Automatic pairing characters.
      require('mini.pairs').setup({})

      -- Highlight hex colors and custom patterns 
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
