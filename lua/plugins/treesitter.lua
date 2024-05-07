return {
  {
    -- Let neovim understand the structure of your document.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "bash", "regex", "vim", "vimdoc", "lua", "luadoc", "php", "markdown", "markdown_inline" },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
      })
    end
  }
}

