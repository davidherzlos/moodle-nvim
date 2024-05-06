return {
  -- I like a minimal but elegant status line.
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      local status_line = require('mini.statusline')
      status_line.setup({ use_icons = vim.g.have_nerd_font })
      status_line.section_location = function()
        return '%2l:%-2v'
      end
    end
  },
}
