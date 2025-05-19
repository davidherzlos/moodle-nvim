--[[General]]--

-- Clear highlight search when pressing <Esc> in normal mode.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true, desc = "No hightlight search!"})

--[[Quickfixlists]]--

-- Navigate easier in quickfixlists or location lists.
vim.keymap.set("n", "<leader>co", "<cmd>copen<CR>", { noremap = true, silent = true, desc = "QuickList: Open" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<CR>", { noremap = true, silent = true, desc = "QuickList: Close" })
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", { noremap = true, silent = true, desc = "LocationList: Open" })
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", { noremap = true, silent = true, desc = "LocationList: Close" })

-- Utility function to go first on qf and loc lists.
local function first_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 then
    vim.cmd('lfirst')
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 then
    vim.cmd('cfirst')
  end
end

-- Utility function to go next on qf and loc lists.
local function next_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 and loclist.idx ~= loclist.size then
    vim.cmd('lnext')
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 and qflist.idx ~= qflist.size then
    vim.cmd('cnext')
  end
end

-- Utility function to go prev on qf and loc lists.
local function prev_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 and loclist.idx ~= 1 then
    vim.cmd('lprev')
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 and qflist.idx ~= 1 then
    vim.cmd('cprev')
  end
end

-- Utility function to go last on qf and loc lists.
local function last_on_list()
  local loclist = vim.fn.getloclist(0, { idx = 0, size = 1 })
  if loclist.size > 0 then
    vim.cmd('llast')
  end
  local qflist = vim.fn.getqflist({ idx = 0, size = 1 })
  if qflist.size > 0 then
    vim.cmd('clast')
  end
end
vim.keymap.set('n', '<M-CR>', toggle_fullscreen, { noremap = true, silent = true })
