return {
  -- Telescope fuzzy finder.
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fh', builtin.search_history, {})
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
      vim.keymap.set('n', '<leader>fr', builtin.resume, {})
    end,
    dependencies = { 
      -- I dont know what plenary is for.	
      'nvim-lua/plenary.nvim', 
      { 
        -- This is useful for pretty icons.
        'nvim-tree/nvim-web-devicons', 
	enabled = vim.g.have_nerd_font 
      }
    }
  },
}
