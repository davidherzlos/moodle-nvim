-- Install and configure Debugging capabilities for neovim.
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- TODO: Recommended to use neodev.nvim for better dev experience.
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      },

    -- Bootstrapp all the configuration here.
    config = function()

      -- Ensure adapters are installed properly.
      require("mason").setup({})
      require("mason-nvim-dap").setup({
        ensure_installed = { "php" }
      })

      -- Configure the dapters.
      local dap = require('dap')
      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { vim.loop.os_homedir() .. '/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
      }

      -- Tell dap how to use the adapters.
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

      -- Configure the ui for dap.
      local dapui = require("dapui")
      dapui.setup({})

      -- Add some useful keymaps for debugging.
      vim.keymap.set('n', '<F10>', dap.continue, { desc = 'Debugger: Continue' })
      vim.keymap.set('n', '<F11>', dapui.toggle, { desc = 'Debugger: Toggle' })
      vim.keymap.set('n', '<F12>', dap.repl.toggle, { desc = 'Debugger: Repl toggle' })

      -- Breakpoints.
      vim.keymap.set('n', '<Leader>l', function()dap.toggle_breakpoint(nil, nil, vim.fn.input('Expresion to log: '))end, { desc = 'Debugger: Set Logpoint' })
      vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = 'Debugger: Toggle breakpoint' })
      vim.keymap.set('n', '<Leader>B', dap.clear_breakpoints, { desc = 'Debugger: Clear breakpoints' })

      -- Evaluate values under the cursor.
      vim.keymap.set('n', '<space>?', function()require('dapui').eval(nil, { enter = true })end, { desc = 'Debugger: Eval variable'})

      -- Some experimental keymaps for opening componentd as centered windows.
      --vim.keymap.set('n', '<Leader>df', function()local widgets = require('dap.ui.widgets')widgets.centered_float(widgets.frames)end)
      -- vim.keymap.set('n', '<Leader>ds', function()local widgets = require('dap.ui.widgets')widgets.centered_float(widgets.scopes)end)

      -- Tell dap when the ui needs to toggle automatically.
      dap.listeners.before.attach.dapui_config = function()dapui.open()end
      dap.listeners.before.launch.dapui_config = function()dapui.open()end
      dap.listeners.before.event_terminated.dapui_config = function()dapui.close()end
      dap.listeners.before.event_exited.dapui_config = function()dapui.close()end

      -- Finally some icons customizations.
      -- NOTE: texthl is hardcoded to the one that has the desired color.
      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = ""})
      sign("DapLogPoint", { text = " ", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
      sign("DapStopped", { text = " ", texthl = "DapLogPoint", linehl = "", numhl = ""})
    end
  },
}

