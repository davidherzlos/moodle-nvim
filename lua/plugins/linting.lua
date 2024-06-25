-- Add capabilities to neovim for consuming linters.
return {
  -- The order of the plugins setup matters.
  {
    "williamboman/mason.nvim",
    'mfussenegger/nvim-lint',
  },
  {
    "rshkarin/mason-nvim-lint",
    config = function()

      -- Setup mason and nvim-lint first,
      require("mason").setup({})
      local lint = require('lint')

      -- Add autocmd to lint the current file on specific events.
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end
      })

      -- Configure php linter behavior.
      local phpcs = require('lint').linters.phpcs
      phpcs.command = vim.loop.cwd() .. "/vendor/bin/phpcs"
      phpcs.args = {
        '--report=json',
        '-',
      }

      -- Associate the configured linters to filetypes.
      lint.linters_by_ft = {
        php = { "phpcs" },
      }

      -- Finally ensure all linters are installed.
      require("mason-nvim-lint").setup({
        ensure_installed = {}
      })

    end
  }
}

