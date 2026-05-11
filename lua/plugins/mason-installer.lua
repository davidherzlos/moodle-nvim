local tools = {}

-- Merge coding tools.
for _, v in ipairs(require('config.tooling').export_names()) do
  table.insert(tools, v)
end

-- Merge lsp tools.
for _, v in ipairs(require('config.lsp').export_names()) do
  table.insert(tools, v)
end

-- Install all tools at once.
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = tools
    }
  }
}
