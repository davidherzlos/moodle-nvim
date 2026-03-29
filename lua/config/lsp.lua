-- Configure the communication between neovim and the LSPs.
-- See more servers configs: https://github.com/neovim/nvim-lspconfig/tree/master/lsp

local utils = require('config.utils')
local lsp_configs = {}

-- Setup LSP for bash programming.
-- https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
lsp_configs['bash-language-server'] = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'bash', 'sh', 'zsh' },
  root_markers = { '.git' },
  settings = {
    bashIde = {
      globPattern = vim.  env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
    },
  },
}

-- Setup LSP for lua programming.

-- https://luals.github.io/wiki/settings/
lsp_configs['lua-language-server'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
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
        enable = true,
      },
      signatureHelp = {
        enable = true,
      },
      hover = {
        enable = true;
      }
    }
  }
}

-- Setup LSP for php programming.


-- Intelephense (license)
-- https://github.com/bmewburn/vscode-intelephense/blob/master/package.json
lsp_configs['intelephense'] = {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = utils.get_project_root_markers(),
  settings = {
    intelephense = {
      completion = {
        fullyQualifyGlobalConstantsAndFunctions = true
      },
      format = {
        enable = false
      },
      environment = {
        documentRoot = "${workspaceFolder}",
        phpVersion = utils.get_php_version()
      },
      codeLens = {
        references = {
          enable = true,
        },
        implementations = {
          enable = true,
        },
        usages = {
          enable = true
        },
        overrides = {
          enable = true
        },
        parent = {
          enable = true
        }
      },
    },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
  end,
}

-- PHPActor
-- https://phpactor.readthedocs.io/en/master/reference/configuration.html
lsp_configs['phpactor'] = {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.phpactor.json', '.phpactor.yml' },
  workspace_required = true,
  init_options = { 
    ["language_server_phpstan.enabled"] = false,
    ["language_server_psalm.enabled"] = false,
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.completionProvider = false
    client.server_capabilities.definitionProvider = false
    client.server_capabilities.implementationProvider = false
    client.server_capabilities.referencesProvider = false
    client.server_capabilities.documentSymbolProvider = false
    client.server_capabilities.workspaceSymbolProvider = false
    client.server_capabilities.renameProvider = false
    client.server_capabilities.hoverProvider = false
    -- vim.print(client.server_capabilities)
  end,
}

-- TODO: Integrate phptools from devsense.

-- Install lsp dependencies.
require('mason-tool-installer').setup({
  ensure_installed = vim.tbl_keys(lsp_configs)
})

-- Pass config and enable lsp.
for server, config in pairs(lsp_configs) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

