return {
  -- Configure the communication between neovim and the LSPs.
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason package manager for LSPs. DAPs, Linters, Formatters, etc.
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end
      },
      {
        -- Ensure all specified Language Servers (LSPs) are installed.
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "phpactor" }
          })
        end
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Specify server here that i want to install.
      lspconfig.lua_ls.setup({})
      lspconfig.phpactor.setup({})

      -- Attach the lsp actions needed.
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)

          -- This is a little function to don't repeat too much.
          local opts = function(description)
            return { buffer = event.buf, desc = description}
          end

          -- I prefer telescope instead of vim.lsp.buf.definition().
          -- Telescope will display a picker if more definitions are found.
          local telescope = require('telescope.builtin')
          vim.keymap.set('n', '<leader>gd', telescope.lsp_definitions, opts('LSP: [G]oto [D]efinition'))
          vim.keymap.set('n', '<leader>gi', telescope.lsp_implementations, opts('LSP: [G]oto [I]mplementations'))

        end
      })
    end
  },
}

