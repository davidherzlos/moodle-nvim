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
                command = "php-cs-fixer",
                args = {
                    "fix",
                    "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
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
