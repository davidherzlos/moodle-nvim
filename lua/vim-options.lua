-- Indicate we hava e nerd font installed.
vim.g.have_nerd_font = true

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Add line nunbers for easy jumping.
vim.opt.number = true

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Show mode in status line off, we have a custom status line.
vim.opt.showmode = false

-- Set highlight on search, but clear on pressing <Esc> in normal mode.
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Enable 24 bit colours in the terminal.
vim.opt.termguicolors = true

