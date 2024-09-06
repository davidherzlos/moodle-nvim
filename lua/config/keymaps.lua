-- This file contains all the keymaps for the plugins.
vim.keymap.set('n', '<leader>su', function() require('symbol-usage').toggle() end, { desc = 'Symbols Usage: [S]ymbols [To]ggle' })

-- Language server Protocol.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)

    local opts = function(description)
      return { buffer = event.buf, desc = description}
    end

    local telescope = require('telescope.builtin')
    -- Configure some minimal keybindings.
    vim.keymap.set('n', '<leader>sd', function() telescope.lsp_definitions({ jump_type = 'never' }) end, opts('LSP: [S]earch [D]efinition'))
    vim.keymap.set('n', '<leader>si', telescope.lsp_implementations, opts('LSP: [S]earch [I]mplementations'))
    vim.keymap.set('n', '<leader>sr', telescope.lsp_references, opts('LSP: [S]earch [R]eferences'))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('LSP: [R]ename Symbol'))
    vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols, opts('LSP: [D]ocument Symbols'))
    vim.keymap.set("n", "<leader>ws", function()
      vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
        telescope.lsp_workspace_symbols({ query = query })
      end)
    end, opts("LSP: [W]orkspace [S]ymbols"))
  end
})
