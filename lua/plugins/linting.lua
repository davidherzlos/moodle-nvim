return {
  -- Nvim-lint adds neovim capabilities to consume linters. 
  {
    'mfussenegger/nvim-lint',
    -- event = {
    --     "BufReadPre", "BufNewFile"
    -- },
    dependencies = {
      "williamboman/mason.nvim", -- Mason is the package manager to install tools.
    },
  },
  {
    "rshkarin/mason-nvim-lint", -- To ensure linters are auto installed.
    config = function()
      -- Setup Mason.
      require("mason").setup({})

      -- Configure nvim-lint.
      local lint = require('lint')

      -- Create an auto command to trigger linting in my php files.
      vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter", "BufReadPre", "BufWritePost", "CursorHold", "CursorHoldI" }, {
        callback = function()
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          lint.try_lint()
        end,
       })
      local phpcs = require('lint').linters.phpcs
      phpcs.command = vim.loop.cwd() .. "vendor/bin/phpcs"
      phpcs.args = {
        '--report=json',
        '-',
      }

      lint.linters_by_ft = {
        php = { "phpcs" },
      }

      -- Configure mason-nvim-lint.
      require("mason-nvim-lint").setup({
        ensure_installed = {}
      })
    end
  }
}

