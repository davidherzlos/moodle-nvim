-- This file contains all the keymaps for the plugins.
vim.keymap.set('n', '<leader>st', function() require('symbol-usage').toggle() end, { desc = 'Symbols Usage: [S]ymbols [To]ggle' })
