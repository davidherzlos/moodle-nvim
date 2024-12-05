--[[General]]--

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Clear highlight search when pressing <Esc> in normal mode.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true })

-- Open diagnostic quickfixlists and locationlists easier.
vim.keymap.set("n", "<leader>dc", "<cmd>lua vim.diagnostic.setqflist()<CR>", { noremap = true, silent =true, desc = "Diagnostics: Open qflist" })
vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true, silent =true, desc = "Diagnostics: Open loclist" })

-- Navigate easier in quickfixlists or location lists.
vim.keymap.set("n", "]c", "<cmd>cnext<CR>", { noremap = true, silent =true, desc = "QuickList: Go to next" })
vim.keymap.set("n", "[c", "<cmd>cprev<CR>", { noremap = true, silent =true, desc = "QuickList: Go to prev" })
vim.keymap.set("n", "[[c", "<cmd>cfirst<CR>", { noremap = true, silent =true, desc = "QuickList: Go to first" })
vim.keymap.set("n", "]]c", "<cmd>clast<CR>", { noremap = true, silent =true, desc = "QuickList: Go to last" })
vim.keymap.set("n", "]l", "<cmd>lnext<CR>", { noremap = true, silent =true, desc = "LocationList: Go to next" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>", { noremap = true, silent =true, desc = "LocationList: Go to prev" })
vim.keymap.set("n", "[[l", "<cmd>lfirst<CR>", { noremap = true, silent =true, desc = "LocationList: Go to first" })
vim.keymap.set("n", "]]l", "<cmd>llast<CR>", { noremap = true, silent =true, desc = "QuickList: Go to last" })
vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { noremap = true, silent =true, desc = "QuickList: Open" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { noremap = true, silent =true, desc = "QuickList: Close" })
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", { noremap = true, silent =true, desc = "LocationList: Open" })
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", { noremap = true, silent =true, desc = "LocationList: Close" })

-- Map buffer navigation commands using Alt.
vim.keymap.set('n', '<M-n>', '<cmd>bprev<CR>', { noremap = true, silent = true, desc = 'Buffers: Next buffer' })
vim.keymap.set('n', '<M-p>', '<cmd>bnext<CR>', { noremap = true, silent = true, desc = 'Buffers: Previous buffer' })
vim.keymap.set('n', '<M-q>', '<cmd>bd<CR>', { noremap = true, silent = true, desc = 'Buffers: Delete buffer' })
vim.keymap.set('n', '<M-s>', '<C-^>', { noremap = true, silent = true, desc = 'Buffers: Switch ast buffer' })

-- Remap some window using Alt instead of Ctrl.
vim.keymap.set('n', '<C-u>', '<C-u>', { noremap = true, silent = true, desc = 'Navigation: Scroll up' })
vim.keymap.set('n', '<C-d>', '<C-d>', { noremap = true, silent = true, desc = 'Navigation: Scroll down' })
-- vim.keymap.set('n', '<M-e>', '<C-e>', { noremap = true, silent = true, desc = 'Navigation: Scroll down (one line)' })
-- vim.keymap.set('n', '<M-y>', '<C-y>', { noremap = true, silent = true, desc = 'Navigation: Scroll up (one line)' })
-- vim.keymap.set('n', '<M-f>', '<C-f>', { noremap = true, silent = true, desc = 'Navigation: Scroll down (one screen)' })
-- vim.keymap.set('n', '<M-b>', '<C-b>', { noremap = true, silent = true, desc = 'Navigation: Scroll up (one screen)' })
-- vim.keymap.set('n', '<M-i>', '<C-i>', { noremap = true, silent = true, desc = 'Navigation: Jump next cursor' })
-- vim.keymap.set('n', '<M-o>', '<C-o>', { noremap = true, silent = true, desc = 'Navigation: Jump previous cursor' })
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
