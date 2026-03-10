return {
  {
    -- Debugging capabilities for Neovim.
    'mfussenegger/nvim-dap',
    dependencies = {
      "nvim-neotest/nvim-nio",
      "folke/lazydev.nvim",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      {
        "igorlfs/nvim-dap-view",
        opts = {
          winbar = {
            show = true,
            sections = {
              "watches",
              "exceptions",
              "breakpoints",
              "threads",
              "scopes",
              "repl",
            },
            -- Must be one of the sections declared above
            default_section = "scopes",
            controls = {
              enabled = true,
              position = "right",
              buttons = {
                "play",
                "step_over",
                "step_into",
                "step_out",
                "step_back",
                "run_last",
                "terminate",
                "disconnect",
              },
            },
          },
          windows = {
            size = 0.5,
            position = "right",
            terminal = {
              size = 0.5,
              position = "left",
              -- List of debug adapters for which the terminal should be ALWAYS hidden
              hide = {},
            },
          },
          -- Controls how to jump when selecting a breakpoint or navigating the stack
          -- Comma separated list, like the built-in 'switchbuf'. See :help 'switchbuf'
          -- Only a subset of the options is available: newtab, useopen, usetab and uselast
          -- Can also be a function that takes the current winnr and the bufnr that will jumped to
          -- If a function, should return the winnr of the destination window
          switchbuf = "uselast",
          -- Auto open when a session is started and auto close when all sessions finish
          auto_toggle = true,
        }
      },
    },
    config = function()
      -- Type checking and autocompletions (not for PHP).
      require("lazydev").setup({
        library = { "nvim-dap-ui" },
      })

      require("mason").setup()

      -- Ensure adapters are installed properly.
      -- NOTE: if the debugger doesn't work first time, try running :MasonInstall php-debug-adapter
      require("mason-nvim-dap").setup({
        ensure_installed = { "php" },
        automatic_installation = true,
      })

      -- Configure the adapters.
      local dap = require('dap')

      -- Register the adapter for php.
      dap.adapters.php = {
        type = 'executable',
        command = vim.fn.stdpath('data') .. '/mason/bin/php-debug-adapter',
      }

      -- Tell dap how to use the adapters.
      dap.configurations.php = {
        {
          name = 'Listen for Xdebug',
          type = 'php',
          request = 'launch',
          port = 9003,
          -- Path mappings are needed when editing the code from the host.
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}"
          }
        }
      }

      local dapui = require("dapui")
      local dapview = require("dap-view")
      dapui.setup({})

      -- Open Dap interfaces.
      vim.keymap.set('n', '<Leader>duo', function() dapui.open() end, { desc = 'Dapui: Open dap-ui' })
      vim.keymap.set('n', '<Leader>duc', function() dapui.close() end, { desc = 'Dapui: Close dap-ui' })
      vim.keymap.set('n', '<Leader>dvo', function() dapview.open() end, { desc = 'Dapview: Open dap-view' })
      vim.keymap.set('n', '<Leader>dvc', function() dapview.close() end, { desc = 'Dapview: Close dap-view' })

      -- Breakpoints management.
      vim.keymap.set('n', '<Leader>br', dap.toggle_breakpoint, { desc = 'Dap: Breakpoint' })
      vim.keymap.set('n', '<Leader>lp', function()dap.toggle_breakpoint(nil, nil, vim.fn.input('Logpoint: '))end, { desc = 'Dap: Logpoint' })

      -- Dap UI controls.
      vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Dap: Continue' })
      vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'Dap: Step Over' })
      vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Dap: Step Into' })
      vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Debugger: Step Out' })
      vim.keymap.set('n', '<F9>', dap.run_to_cursor, { desc = 'Dap: Run to Cursor' })
      vim.keymap.set('n', '<F10>', function() dap.terminate() end, { desc = 'Dap: Terminate' })

      -- Define DAP signs with icons
      vim.fn.sign_define("DapBreakpoint", {
        text = "󰝥 ",
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = ""
      })

      vim.fn.sign_define("DapLogPoint", {
        text = "󰝥 ",
        texthl = "DapLogPoint",
        linehl = "",
        numhl = ""
      })

      vim.fn.sign_define("DapStopped", {
        text = " ",
        texthl = "DapStopped",
        linehl = "",
        numhl = ""
      })
    end
  },
}
