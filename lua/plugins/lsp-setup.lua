-- Configure the communication between neovim and the LSPs.
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "williamboman/mason.nvim", -- Package manager for LSPs. DAPs, Linters, Formatters, etc.
      "williamboman/mason-lspconfig.nvim", -- Ensure all specified tools are installed.
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
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
          "bashls",
          "lua_ls",
          "intelephense",
          "biome",
          "ts_ls",
        }
      })
    end
  },
}
