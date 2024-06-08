return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        sign_priority = 6,
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
      }
    end
  }
}

