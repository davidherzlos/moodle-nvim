-- Configure the communication between neovim and the LSPs.
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- Mason package manager for LSPs. DAPs, Linters, Formatters, etc.
      "williamboman/mason-lspconfig.nvim", -- Ensure all specified Language Servers (LSPs) are installed.
    },
    config = function()
      -- First setup mason,
      require("mason").setup()

      -- Then specify servers that that i want to install.
      require("mason-lspconfig").setup({
        ensure_installed = { "bashls", "lua_ls", "intelephense" }
      })

      -- Configure the language servers.
      local lspconfig = require("lspconfig")

      -- Setup for bash programming.
      lspconfig.bashls.setup({})

      -- Setup for lua programming.
      lspconfig.lua_ls.setup({})

      -- Setup for php programming.
      lspconfig.intelephense.setup({
        settings = {
          intelephense = {
            files = {
              maxSize = {
                type = "number",
                default = 1500000,
              },
            },
          },
        }
      })




      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
        },
      })

    end
  },
}

