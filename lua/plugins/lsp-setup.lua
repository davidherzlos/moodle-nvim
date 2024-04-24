return {
  -- Mason package manager for LSPs. DAPs, Linters, Formatters, etc.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    -- Install the Language Servers (LSPs).
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" , "tsserver" , "phpactor" }
      })
    end
  },
  -- Configure the specific neovim configs for the LSPs.
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
 
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.phpactor.setup({})
    end
  }
}

