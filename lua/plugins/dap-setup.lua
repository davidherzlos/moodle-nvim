-- Install the Debugger Adapter protocol for neovim.
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      "williamboman/mason.nvim", -- Mason package manager for LSPs. DAPs, Linters, Formatters, etc.
      "jay-babu/mason-nvim-dap.nvim", -- Ensure all Debugger Adapter Protocols (Dapss) are installed.
      -- DAP plugin needs a UI to be suitable for easy use.
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          -- TODO: Install neodev.nvim as a dependency for a better experience.
          "nvim-neotest/nvim-nio"
        }
      },
    },
    config = function()
      -- First setup mason.
      require("mason").setup({})

      -- Then specify the debug adapters that i want to install. 
      require("mason-nvim-dap").setup({
        ensure_installed = { "php" }
      })

      -- Asumming the adapters is installed, lets configure them.
      local dap = require('dap')

      -- We only configure php.
      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { vim.loop.os_homedir() .. '/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
      }
      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug',
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "${workspaceFolder}"
          }
        }
      }

      -- Then Connect the DAP listeners to the DAP-UI actions.
      local dapui = require("dapui")
      dapui.setup({})

      dap.listeners.before.attach.dapui_config = function()dapui.open()end
      dap.listeners.before.launch.dapui_config = function()dapui.open()end
      dap.listeners.before.event_terminated.dapui_config = function()dapui.close()end
      dap.listeners.before.event_exited.dapui_config = function()dapui.close()end

      -- Finally add some required keybindings for debugging.
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debugger: Continue' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debugger: Step over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debugger: Step into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debugger: Step out' })
      vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'Debugger: Toggle breakpoint' })
      vim.keymap.set('n', '<Leader>B', dap.set_breakpoint, { desc = 'Debugger: Set breakpoint' })
      vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = 'Open Repl' })
    end
  },
}

