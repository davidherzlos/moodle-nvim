-- This module groups all regarding mason tools installation.
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function ()
      require('mason-tool-installer').setup({
        ensure_installed = {
          "phpcbf",
          "php-cs-fixer",
          "beautysh"
        },
      })
    end
  },
}
