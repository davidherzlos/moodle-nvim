return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('treesitter-context').setup({
        enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 5, -- Maximum number of lines to show for a single context
        trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = "·",
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
        vim.keymap.set("n", "<leader>tc", ":TSContextEnable<CR>", { desc = "[T]reesitter [Context] Enable"})
        vim.keymap.set("n", "<leader>q", ":TSContextDisable<CR>", { desc = "[T]reesitter [Context] Disable"})
    end
  }
}
