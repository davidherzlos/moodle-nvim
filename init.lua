-- Order matters here.

-- Load default vim config options.
require("config.options")

-- Then install lazy package manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Next require all default plugins.
require("lazy").setup("plugins", {
  ui = {
    icons = vim.g.have_nerd_font and {}
  }
})

-- Load default autocommands.
require("config.autocmds")

-- Set default colorscheme.
vim.cmd("colorscheme "..vim.g.default_colorscheme)

-- Load default keymaps.
require("config.keymaps")
