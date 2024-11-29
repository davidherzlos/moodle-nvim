-- This file contains all the keymaps for the plugins.
vim.keymap.set('n', '<leader>su', function() require('symbol-usage').toggle() end, { desc = 'Symbols Usage: [S]ymbols [To]ggle' })

-- Navigate easier in quickfixlists or location lists.
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "QuickList: Go to next" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "QuickList: Go to prev" })
vim.keymap.set("n", "[[q", "<cmd>cfirst<CR>", { desc = "QuickList: Go to first" })
vim.keymap.set("n", "]]q", "<cmd>clast<CR>", { desc = "QuickList: Go to last" })

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
    vim.keymap.set('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, opts('LSP: Dynamic [W]orkspace Symbols'))
    vim.keymap.set("n", "<leader>Ws", function()
      vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
        telescope.lsp_workspace_symbols({ query = query })
      end)
    end, opts("LSP: [W]orkspace [S]ymbols"))
  end
})

-- Map buffer navigation commands using Alt.
vim.keymap.set('n', '<M-n>', '<cmd>bprev<CR>', { noremap = true, silent = true, desc = 'Buffers: Next buffer' })
vim.keymap.set('n', '<M-p>', '<cmd>bnext<CR>', { noremap = true, silent = true, desc = 'Buffers: Previous buffer' })
vim.keymap.set('n', '<M-c>', '<cmd>bdel<CR>', { noremap = true, silent = true, desc = 'Buffers: Delete buffer' })
vim.keymap.set('n', '<M-l>', '<C-^>', { noremap = true, silent = true, desc = 'Buffers: Last buffer' })

-- Remap some window using Alt instead of Ctrl.
vim.keymap.set('n', '<M-u>', '<C-u>', { noremap = true, silent = true, desc = 'Navigation: Scroll up' })
vim.keymap.set('n', '<M-d>', '<C-d>', { noremap = true, silent = true, desc = 'Navigation: Scroll down' })
vim.keymap.set('n', '<M-e>', '<C-e>', { noremap = true, silent = true, desc = 'Navigation: Scroll down (one line)' })
vim.keymap.set('n', '<M-y>', '<C-y>', { noremap = true, silent = true, desc = 'Navigation: Scroll up (one line)' })
vim.keymap.set('n', '<M-f>', '<C-f>', { noremap = true, silent = true, desc = 'Navigation: Scroll down (one screen)' })
vim.keymap.set('n', '<M-b>', '<C-b>', { noremap = true, silent = true, desc = 'Navigation: Scroll up (one screen)' })
vim.keymap.set('n', '<M-i>', '<C-i>', { noremap = true, silent = true, desc = 'Navigation: Jump next cursor' })
vim.keymap.set('n', '<M-o>', '<C-o>', { noremap = true, silent = true, desc = 'Navigation: Jump previous cursor' })
vim.keymap.set('n', '<M-w>', '<C-w>', { noremap = true, silent = true, desc = 'Window: Window maps' })

-- Remap some editing keys.
vim.keymap.set('n', 'r', '<C-r>', { noremap = true, silent = true, desc = 'Editing: Redo' })

-- Add an utility function to toggle full screen on an active window in split view.
local fullscreen = false
local function toggle_fullscreen()
  if not fullscreen then
    vim.cmd("resize")
    vim.cmd("vertical resize")
    fullscreen = true
  else
    vim.cmd("wincmd =")
    fullscreen = false
  end
end
vim.keymap.set('n', '<M-CR>', toggle_fullscreen, { noremap = true, silent = true })
