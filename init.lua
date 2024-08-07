-- Require our module for vim options.
require("vim-options")

-- Set signs for diagnostic messages.
local signs = {
  Error = "",
  Warn = "󰞏",
  Hint = "",
  Info = ""
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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

-- And finally tell lazy to require our plugins.
require("lazy").setup("plugins", {}, {
  ui = {
    icons = vim.g.have_nerd_font and {}
  }
})

-- Once all is setup, load the colorscheme.
vim.cmd.colorscheme 'tokyonight'

-- Load our custom configuration.
require("config")

-- This keymap is just a personal command i use to test some lua code.
-- vim.keymap.set("n", "<leader>rt", function () require('lua-guide.language-test').run() end, { desc = "[R]un Lua [T]ests"})

