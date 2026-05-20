return {
  -- This module defined all related utilities from mini plugins.
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      -- Mini file manager.
      require('mini.files').setup({
        mappings = {
          close = '<ESC>',
          synchronize = ':w<CR>',
        },
        options = {
          permanent_delete = false,
        },
        windows = {
          width_focus = 50,
          width_nofocus = 25,
        },
      })

      -- Open it from the current buffer.
      vim.keymap.set(
        "n", "<leader>em",
        function()
          local buf_name = vim.api.nvim_buf_get_name(0)
          local path = (buf_name ~= "" and vim.fn.filereadable(buf_name) == 1)
            and buf_name
            or (vim.uv or vim.loop).cwd()
          MiniFiles.open(path, false)
        end,
        { noremap = true, silent = true, desc = "Minifiles.nvim" }
      )

      -- Animated indent scope line.
      require('mini.indentscope').setup({
        draw = {
          delay = 1000,
        },
        options = {
          border = 'top',
          try_as_border = true,
        },
      })

      vim.api.nvim_create_autocmd('TermOpen', {
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
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
