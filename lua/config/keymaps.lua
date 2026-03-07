--[[General]]--

-- Clear highlight search when pressing <Esc> in normal mode.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true, desc = "No hightlight search!"})

--[[Quickfixlists]]--

-- Navigate easier in quickfixlists or location lists.
vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { noremap = true, silent = true, desc = "QuickList: Open" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { noremap = true, silent = true, desc = "QuickList: Close" })
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", { noremap = true, silent = true, desc = "LocationList: Open" })
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", { noremap = true, silent = true, desc = "LocationList: Close" })

-- Utility function to check if quickfix list is open
local function is_qf_open()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 and win.loclist == 0 then
      return true
    end
  end
  return false
end

-- Utility function to check if location list is open
local function is_loc_open()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 and win.loclist == 1 then
      return true
    end
  end
  return false
end

-- Utility function to go first on qf and loc lists.
local function first_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 and is_loc_open() then
    vim.cmd('lfirst')
    return
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 and is_qf_open() then
    vim.cmd('cfirst')
  end
end

-- Utility function to go next on qf and loc lists.
local function next_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 and loclist.idx ~= loclist.size and is_loc_open() then
    vim.cmd('lnext')
    return
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 and qflist.idx ~= qflist.size and is_qf_open() then
    vim.cmd('cnext')
  end
end

-- Utility function to go prev on qf and loc lists.
local function prev_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 and loclist.idx ~= 1 and is_loc_open() then
    vim.cmd('lprev')
    return
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 and qflist.idx ~= 1 and is_qf_open() then
    vim.cmd('cprev')
  end
end

-- Utility function to go last on qf and loc lists.
local function last_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 and is_loc_open() then
    vim.cmd('llast')
    return
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 and is_qf_open() then
    vim.cmd('clast')
  end
end

-- Navigate on quickfixlists and locationlists.
-- TODO: redefine this keymas with a new layer.
vim.keymap.set("n", "<C-h>", first_on_list, { noremap = true, silent = true, desc = "Quickfixlists: first" })
vim.keymap.set("n", "<C-j>", next_on_list, { noremap = true, silent = true, desc = "Quickfixlists: next" })
vim.keymap.set("n", "<C-k>", prev_on_list, { noremap = true, silent = true, desc = "Quickfixlists: prev" })
vim.keymap.set("n", "<C-l>", last_on_list, { noremap = true, silent = true, desc = "Quickfixlists: last" })

--[[Diagnostics]]--

-- Open/close diagnostics quickfixlists and locationlists.
vim.keymap.set("n", "<leader>dc", vim.diagnostic.setqflist, { noremap = true, silent = true, desc = "Diagnostics: Open quickfixlist" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Diagnostics: Open locationlist" })

-- Open/close todo-comments quickfixlists and locationlists.
vim.keymap.set("n", "<leader>td", '<cmd>TodoQuickFix<CR>', { noremap = true, silent = true, desc = "TodoComments: TodoQuickFix" })

--[[Windows and Buffers]]--

vim.keymap.set('n', '<leader>oo', function ()
  vim.cmd('only')
  vim.opt.laststatus = 2
end, { desc = 'Only this window' })

--[[Neovim utils]]--

-- Source the current file.
vim.keymap.set('n', '<leader>x', function() vim.cmd('luafile %') print('File was sourced') end, { noremap = true, silent = true, desc = 'Neovim: source file' })
