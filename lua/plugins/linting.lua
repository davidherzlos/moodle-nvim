return {
    {
        'mfussenegger/nvim-lint',
        -- event = {
        --     "BufReadPre", "BufNewFile"
        -- },
        init = function()
            local lint = require("lint")
            -- Create an auto command to trigger linting in my php files.
            vim.api.nvim_create_autocmd(
                { "TextChanged", "TextChangedI", "BufEnter", "BufReadPre", "BufWritePost", "CursorHold", "CursorHoldI" }, 
                {
                    callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    lint.try_lint()
                end,
                }
            )
        end,
        config = function()
            local lint = require('lint')
            local phpcs = require('lint').linters.phpcs
            phpcs.args = {
                '--standard=PSR12',
                '--report=json',
                '-',
            }
            lint.linters_by_ft = {
                php = { "phpcs" },
            }
        end
    },
}

