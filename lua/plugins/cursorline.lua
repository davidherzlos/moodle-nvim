return
  {
    {
      -- Animate the cursor.
      "sphamba/smear-cursor.nvim", 
      opts = {
        -- Smear cursor when switching buffers or windows.
        smear_between_buffers = false,
        -- Smear cursor when moving within line or to neighbor lines.
        smear_between_neighbor_lines = true,
        -- Draw the smear in buffer space instead of screen space when scrolling
        scroll_buffer_space = false,
        -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
        -- Smears will blend better on all backgrounds.
        legacy_computing_symbols_support = false,
      }
    },
    {
      -- Define finer behavior of cursorline.
      'tummetott/reticle.nvim',
      event = 'VeryLazy', -- optionally lazy load the plugin
      opts = {
        on_startup = {
          cursorline = true,
          cursorcolumn = false,
        },
        always_highlight_number = true,
        follow = {
          cursorline = true,
        },
        disable_in_insert = true,
        disable_in_diff = true,
        never = {
          cursorline = {
            'nofile',
            'DressingInput',
            'TelescopePrompt',
            'dapui_stacks',
            'dapui_breakpoints',
            'dapui_scopes',
            'dapui_console',
            'dap-view',
          },
        },
      }
    },
    -- Highligh color column when needed by filetype.
    {
      "m4xshen/smartcolumn.nvim",
      opts = {
        disabled_filetypes = {
          "snacks_dashboard",
          "qf",
        },
        colorcolumn = "100",
        custom_colorcolumn = {
          python = "80", php = "132", lua = "100", javascript = "100",
        },
        scope = 'line'
      }
    },
  }
