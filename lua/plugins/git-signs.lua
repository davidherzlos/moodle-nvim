return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '+'  },
          change       = { text = '+'  },
        },
        word_diff = false,
        current_line_blame = true,
        sign_priority = 6,
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
      }
    end
  }
}

