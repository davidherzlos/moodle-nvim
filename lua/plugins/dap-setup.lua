return {
  -- Install the Debugger Adapter protocol for neovim.
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Mason package manager for LSPs. DAPs, Linters, Formatters, etc.
      {
        "williamboman/mason.nvim",
      },
      -- Ensure all Debugger Adapter Protocols (Dapss) are installed.
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          --require("mason-nvim-dap").setup({
            --ensure_installed = { "php" }
          --})
        end
      },
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio"
          -- TODO: Install neodev.nvim as a dependency for a better experience.
        }
      },
    },
    config = function()
      local dap = require('dap')
      local dapui = require("dapui")

      dapui.setup({})

      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { '/home/davidoc/vscode-php-debug/out/phpDebug.js' }
      }

      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug',
          port = 9003,
          pathMappings = {
            ["/var/www/html"] = "/home/davidoc/repos/moodle"
          }
        }
      }

      dap.listeners.before.attach.dapui_config = function()dapui.open()end
      dap.listeners.before.launch.dapui_config = function()dapui.open()end
      dap.listeners.before.event_terminated.dapui_config = function()dapui.close()end
      dap.listeners.before.event_exited.dapui_config = function()dapui.close()end

      -- Configure some relevant keybindings.
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

