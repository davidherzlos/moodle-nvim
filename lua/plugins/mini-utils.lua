return {
  -- This module defined all related utilities from mini plugins.
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      -- MiniDiff to highlight signs with git changes.
      require('mini.diff').setup({
        view = {
          signs = { add = '█', change = '█', delete = '█' },
        },
      })
      vim.keymap.set('n', '<leader>Gp', "<cmd>lua MiniDiff.toggle_overlay()<CR>", { desc = '[G]it [p]review worktree'})

      -- Mini file manager.
      require('mini.files').setup({ mappings = { close = '<ESC>' } })

      -- Open it from the current buffer.
      vim.keymap.set(
        "n", "<leader>fm",
        "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>",
        { noremap = true, silent = true, desc = "Minifiles: [File] [M]anager open local" }
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
