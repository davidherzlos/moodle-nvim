return {
  -- Conform adds capabilities to neovim for consuming external formatter.
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = {"ConformInfo"},
    dependencies = {
      "williamboman/mason.nvim", -- Mason is the package manager to install tools.
    },
  },
  {
    "LittleEndianRoot/mason-conform", -- To ensure formaters are auto installed.
    config = function()
      -- Setup Mason
      require("mason").setup({
         log_level = vim.log.levels.DEBUG
      })

      -- Configure conform.
      require("conform").setup({
        formatters_by_ft = {
          php = { "phpcbf" },
          sh = { "beautysh" },
        },
        formatters = {
          phpcbf = {
            command = vim.loop.cwd() .. "/vendor/bin/phpcbf",
            args = {
              "$FILENAME"
            },
            stdin = false,
          },
          beautysh = {
            command = vim.loop.os_homedir() .. "/.local/share/nvim/mason/bin/beautysh",
            args = {
              "--indent-size=2",
              "--force-function-style=paronly",
              "-",
            },
          }
        },
        format_on_save = {
          lsp_fallback = false,
          timeout_ms = 1000,
        },
        notify_on_error = true,
      })

      -- Configure mason-conform.
      require("mason-conform").setup({
        ensure_installed = {},
        quiet_mode = true,
      })
    end
  },
}
