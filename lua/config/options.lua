--[[General configuration]]--

-- Default indentation.
vim.opt.shiftwidth = 4

-- Set <space> as the leader key.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Sync clipboard between OS and Neovim (you need to install a clipboard tool).
vim.opt.clipboard = 'unnamedplus'

-- Decrease mapped sequence wait time (Displays which-key popup sooner).
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500

--[[Editor]]--

-- Enable relative linenumbers for easy jumping.
vim.opt.relativenumber = true

-- Show which line your cursor is on
vim.opt.cursorline = true

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

-- Set highlight on search.
vim.opt.hlsearch = true

-- Disable ~ on non existing lines.
vim.opt.fillchars = { eob = " " }

-- Add nerdfont icons to the diagnostic signs.
vim.diagnostic.config{
  virtual_text = false,
  underline = false,
  update_in_insert = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "󰞏",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
}

-- Default theme. ayu|solarized|tokyonight|dawnfox.
vim.g.default_colorscheme = 'tokyonight'
