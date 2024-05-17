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
        ensure_installed = { "lua_ls", "intelephense" }
      })

      -- And configure the language servers.
      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({})
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

      -- Finally attach some keybindings for my required lsp actions.
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          -- This is a little function to create quickly some keymaps.
          local opts = function(description)
            return { buffer = event.buf, desc = description}
          end

          local telescope = require('telescope.builtin')

          -- NOTE: I prefer telescope actions instead of vim.lsp.buf API. It would provide a picker if there is 2 or more defs.
          vim.keymap.set('n', '<leader>gd', telescope.lsp_definitions, opts('LSP: [G]oto [D]efinition'))
          vim.keymap.set('n', '<leader>gi', telescope.lsp_implementations, opts('LSP: [G]oto [I]mplementations'))
          vim.keymap.set('n', '<leader>gr', telescope.lsp_references, opts('LSP: [G]oto [R]eferences'))
        end
      })

    end
  },
}

