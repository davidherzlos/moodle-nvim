return
  {
    'tummetott/reticle.nvim',
    enabled = true,
    event = 'VeryLazy', -- optionally lazy load the plugin
    opts = {
      on_startup = {
        cursorline = true,
        cursorcolumn = false,
      },
      follow = {
        cursorline = false,
      },
      never = {
        cursorline = {
          'DressingInput',
          'TelescopePrompt',
          'dapui_stacks',
          'dapui_breakpoints',
          'dapui_scopes',
          'dapui_console',
          'dap-repl',
        },
        cursorcolumn = {},
      },
    }
  }
