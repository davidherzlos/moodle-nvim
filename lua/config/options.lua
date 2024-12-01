--[[General configuration]]--

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Sync clipboard between OS and Neovim (you need to install a clipboard tool).
vim.opt.clipboard = 'unnamedplus'

-- Decrease mapped sequence wait time (Displays which-key popup sooner).
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300


--[[Editor]]--

-- Enable relative linenumbers for easy jumping.
vim.opt.relativenumber = true
vim.o.statuscolumn = "%s  %l%r  "

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 100

-- Preview substitutions when typing.
vim.opt.inccommand = 'split'

-- Copy previous indentation on autoindenting.
vim.opt.copyindent = true

-- Add global flag to toggle code formatting globally.
vim.g.formatters_enabled = false

-- Enable cursor blink.
vim.opt.guicursor = "n:blinkon200,i-ci-ve:ver25"

-- Display whitespace characters to make them more notorious.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


--[[UI and appearance]]--

-- More color support for colors.
vim.opt.termguicolors = true

-- Indicate we hava e nerd font installed.
vim.g.have_nerd_font = true

-- Show mode in status line off, we have a custom status line.
vim.opt.showmode = false

-- Set highlight on search.
vim.opt.hlsearch = true

-- Hide command line when it is not used.
vim.opt.cmdheight =0

-- Disable ~ on non existing lines.
vim.opt.fillchars = { eob = " " }

-- Default theme. tokyonight|solarized|rose-pine.
vim.g.default_colorscheme = 'solarized'
