return {
  -- Status line that plays well with the catppuccin theme.
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup({
        options = {
          -- This will avoid to render the line in dap-ui elements.
          globalstatus = true,
          ignore_focus = {
            "dapui_watches", "dapui_breakpoints",
            "dapui_scopes", "dapui_console",
            "dapui_stacks", "dap-repl"
          },
        },
        sections = {
          lualine_b = {
            {
              'diagnostics',
              symbols = { error ='', warn = '', info = '', hint = ''},
            }
          },
          lualine_c = {
            {
              -- We want the filename as a relative path.
              'filename',
              file_status = true,
              path = 1, -- relative.
            },
          },
        },
      })
    end
  },
}

