--[[General]]--

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Clear highlight search when pressing <Esc> in normal mode.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true })

-- Navigate easier in quickfixlists or location lists.
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "QuickList: Go to next" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "QuickList: Go to prev" })
vim.keymap.set("n", "[[q", "<cmd>cfirst<CR>", { desc = "QuickList: Go to first" })
vim.keymap.set("n", "]]q", "<cmd>clast<CR>", { desc = "QuickList: Go to last" })

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
