return {
  {
    -- Let neovim understand the structure of your document.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "bash", "c", "vim", "vimdoc", "lua", "luadoc", "markdown", "html", "css", "python", "elixir", "javascript", "php"},
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

