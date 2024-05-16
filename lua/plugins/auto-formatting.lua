--formatters.lua
return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = {"ConformInfo"},
    opts = {
        formatters_by_ft = {
            php = { "php-cs-fixer" },
        },
        formatters = {
            ["php-cs-fixer"] = {
                -- You need to install php-cs-fixer manually using mason.
                -- TODO: Automate tooling installation with Mason.
                -- NOTE The moodle standards are in this order:
                -- PSR-12, PSR-1, local coding standards
                -- https://moodledev.io/general/development/policies/codingstyle
                command = "/home/davidoc/.local/share/nvim/mason/bin/php-cs-fixer",
                args = {
                    "fix",
                    "--rules=@PSR1,@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
                    "$FILENAME",
                },
                stdin = false,
            },
        },
        format_on_save = {
                lsp_fallback = false,
                timeout_ms = 1000,
            },
        notify_on_error = true,
    },
}
