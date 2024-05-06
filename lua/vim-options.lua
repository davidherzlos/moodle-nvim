-- Indicate we hava e nerd font installed.
vim.g.have_nerd_font = true

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Add line nunbers for easy jumping.
vim.opt.number = true
--vim.opt.relativenumber = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Show mode in status line.
vim.opt.showmode = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode.
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
