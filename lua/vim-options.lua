-- Indicate we hava e nerd font installed.
vim.g.have_nerd_font = true

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Add line nunbers for easy jumping.
vim.opt.relativenumber = true

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Show mode in status line off, we have a custom status line.
vim.opt.showmode = false

-- Set highlight on search, but clear on pressing <Esc> in normal mode.
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 100

vim.opt.termguicolors = true

-- Preview substitutions when typing.
vim.opt.inccommand = 'split'

-- Display some whitespace characters.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Hide command line when it is not used.
vim.opt.cmdheight =0

-- Copy previous indentation on autoindenting.
vim.opt.copyindent = true

-- Disable ~ on non existing lines.
vim.opt.fillchars = { eob = " " }

-- Enable cursor blink.
vim.opt.guicursor = "n:blinkon200,i-ci-ve:ver25"

-- Give some space to signs and line number.
vim.opt.statuscolumn = " %@SignCb@%s%=%T %@NumCb@%r  "
