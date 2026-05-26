--[[General]]--

--[[Neovim utils]]--

-- Source the current file.
vim.keymap.set('n', '<leader>%', function() vim.cmd('luafile %') vim.notify('File sourced!') end, { noremap = true, silent = true, desc = 'Source file' })

-- Clear highlight search when pressing <Esc> in normal mode.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true, desc = "Clear highlight search"})

--[[Quickfixlists]]--

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
-- TODO: redefine this keymaps with a new layer.
vim.keymap.set("n", "<C-h>", first_on_list, { noremap = true, silent = true, desc = "Qflist firs" })
vim.keymap.set("n", "<C-j>", next_on_list, { noremap = true, silent = true, desc = "Qflist last" })
vim.keymap.set("n", "<C-k>", prev_on_list, { noremap = true, silent = true, desc = "Qflist prev" })
vim.keymap.set("n", "<C-l>", last_on_list, { noremap = true, silent = true, desc = "Qflist last" })

--[[Diagnostics]]--

-- LSP diagnostics for the project and the current file.
vim.keymap.set("n", "<leader>dc", vim.diagnostic.setqflist, { noremap = true, silent = true, desc = "Quickfixlist (cwd)" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Locationlist (file)" })

-- Todo comments to quickfix.
vim.keymap.set("n", "<leader>qt", '<cmd>TodoQuickFix<CR>', { noremap = true, silent = true, desc = "TODO comments" })

--[[Windows and Buffers]]--

--[[Terminal]]--

-- Return to Terminal Normal mode.
vim.keymap.set('t', '<Esc><Esc>', function()
  local chan_id = vim.b.terminal_job_id
  if chan_id then
    local proc_name = vim.fn.jobpid(chan_id)
    -- Add logic based on process if needed
    vim.cmd('stopinsert')
  end
end, { silent = true })
