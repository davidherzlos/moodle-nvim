-- Conform adds capabilities to neovim for consuming formatters.
return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = {"ConformInfo"},
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- Add a helper to decide which formatter to use.
      local php_main_formatter = function ()
        if vim.fn.filereadable(vim.loop.cwd() .. '/vendor/bin/phpcbf') == 1 then
          return 'phpcbf'
        else
          return 'php-cs-fixer'
        end
      end

      -- Async format the file so we can rely slow formatters are gonna work.
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        callback = function(args)
          require("conform").format({
            bufnr = args.buf,
            async = true,
            lsp_format = 'never',
          },
            function()
              vim.cmd "checktime"
            end)
        end,
      })

      require("conform").setup({

        -- Notify and log any error when formatting.
        notify_on_error = true,
        log_level = vim.log.levels.ERROR,

        -- Associate formatters with filetypes.
        formatters_by_ft = {
          php = { php_main_formatter() },
          sh = { "beautysh" },
        },

        -- Customize or override default behavior for some formatters.
        formatters = {
          ['php-cs-fixer'] = {
            command = require('conform.util').find_executable({
              "tools/php-cs-fixer/vendor/bin/php-cs-fixer",
              "vendor/bin/php-cs-fixer",
              vim.loop.os_homedir() .. "/.local/share/nvim/mason/bin/php-cs-fixer"
            }, "php-cs-fixer"),
            args = {
              "fix",
              "$FILENAME",
              "--using-cache=no",
              "--rules=@Symfony",
              "--no-interaction",
              "--quiet",
            },
          },
          beautysh = {
            prepend_args = {
              "--indent-size=2",
              "--force-function-style=paronly",
            },
          }
        },
      })

    end
  },
}
