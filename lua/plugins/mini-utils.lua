return {
  -- This module defined all related utilities from mini plugins.
  {
    'echasnovski/mini.nvim',
    version = false,

    config = function()

      -- Mini file manager.
      require('mini.files').setup()

      -- Open it from the current buffer.
      vim.keymap.set("n", "<leader>fm", "<cmd>lua MiniFiles.open()<CR>", { noremap = true, silent = true, desc = "Minifiles: [F]ile [M]anager open" })
      vim.keymap.set("n", "<leader>f.", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>", { noremap = true, silent = true, desc = "Minifiles: [File] [M]anager open local" })
      vim.keymap.set("n", "<Esc>", "<cmd>lua MiniFiles.close()<CR>", { noremap = true, silent = true, desc = "[M]ini [F]iles Open" })

      -- Animated indent scope line.
      require('mini.indentscope').setup({
        options = {
          border = 'top',
          try_as_border = true,
        },
      })

      -- Automatic pairing characters.
      require('mini.pairs').setup({})

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      vim.opt.laststatus=3

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
