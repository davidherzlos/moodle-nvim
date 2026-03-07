-- Order matters here.

-- Load vim config options.
require("config.options")

-- Bootstrap lazy.nvim.
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

-- Put lazy into the runtimepath.
vim.opt.rtp:prepend(lazypath)

-- Require the plugins folder.
require("lazy").setup("plugins", {
  ui = {
    icons = vim.g.have_nerd_font and {}
  }
})

-- Load commands.
require("config.autocmds")

-- Load keymaps.
require("config.keymaps")

-- Set the colorscheme.
vim.cmd("colorscheme "..vim.g.default_colorscheme)
