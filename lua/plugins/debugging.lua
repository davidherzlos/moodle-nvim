return {
  -- Debugging capabilities for Neovim.
  'mfussenegger/nvim-dap',
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    require("mason").setup()

    -- Ensure adapters are installed properly.
    require("mason-nvim-dap").setup({
      ensure_installed = { "php" }
    })

    -- Configure the adapters.
    local dap = require('dap')
    local adapter = '/.local/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js'

    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      --TEST: Alternative config for php dap adapter.
      --command = vim.fn.stdpath('data') .. '/mason/bin/php-debug-adapter',
      args = { vim.loop.os_homedir() .. adapter }
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

    local dapui = require("dapui")
    dapui.setup({})

    -- Breakpoints.
    vim.keymap.set('n', '<Leader>br', dap.toggle_breakpoint, { desc = 'Dap: Breakpoint' })
    vim.keymap.set('n', '<Leader>lp', function()dap.toggle_breakpoint(nil, nil, vim.fn.input('Logpoint: '))end, { desc = 'Dap: Logpoint' })

    -- Dap UI controls.
    vim.keymap.set('n', '<F5>', function()
      dap.continue()
      dapui.open()
    end, { desc = 'Debugger: Continue' })
    vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'Debugger: Step Over' })
    vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debugger: Step Into' })
    vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Debugger: Step Out' })
    vim.keymap.set('n', '<F10>', function()
      dap.terminate()
      dapui.close()
    end, { desc = 'Debugger: Terminate' })
  end
}

