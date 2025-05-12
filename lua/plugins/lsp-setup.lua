-- Configure the communication between neovim and the LSPs.
return {
  {
    'neovim/nvim-lspconfig',
    enabled = true,
    dependencies = {
      "williamboman/mason.nvim", -- Package manager for LSPs. DAPs, Linters, Formatters, etc.
      "williamboman/mason-lspconfig.nvim", -- Ensure all specified tools are installed.
      -- 'saghen/blink.cmp', -- Completion engine to expand LSPs capabilities.
    },
    opts = {
      servers = {

        -- Setup LSP for bash programming.
        bashls = {},

        -- Setup LSP for lua programming.
        -- https://luals.github.io/wiki/settings/
        lua_ls = {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                return
              end
            end
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT'
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  '~/.local/share/nvim/lazy/solarized.nvim',
                }
              }
            })
          end,
          settings = {
            Lua = {
              hint = {
                enable = false,
              },
              signatureHelp = {
                enable = false,
              },
            }
          }
        },

        -- Setup LSP for php programming.
        -- https://github.com/bmewburn/vscode-intelephense/blob/ff4677f07cb47911852fb265fe16742a312bd9b7/package.json
        intelephense = {
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
        },

        -- Setup LSP for nodejs programming.
        biome = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx", -- Experimental.
            "json",
            "jsonc",
            "astro",
            "svelte",
            "vue",
            "css"
          }
        },

        -- Setup LSP for typescript programming.
        ts_ls = {
          {
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          }
        },
      }
    },
    config = function(_, opts)
      -- List all packages that needs to be installed.
      require("mason").setup({
      })
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "lua_ls",
          "intelephense",
          "biome",
          "ts_ls",
        }
      })

      -- Add some completion capabilities provided by blink to the LPSs.
      -- local lspconfig = require('lspconfig')
      -- for server, config in pairs(opts.servers) do
      --   config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      --   lspconfig[server].setup(config)
      -- end
    end
  },
}
