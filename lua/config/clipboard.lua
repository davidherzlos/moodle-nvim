local M = {}

local function has_native_clipboard()
  local has_display = vim.env.WAYLAND_DISPLAY or vim.env.DISPLAY
  local has_tool = vim.fn.executable('wl-copy') == 1
  or vim.fn.executable('xclip') == 1
  or vim.fn.executable('xsel') == 1
  return has_display and has_tool
end

M.setup_clipboard = function ()
  vim.g.sync_clipboard = vim.g.sync_clipboard ~= false
  if vim.g.sync_clipboard then
    vim.schedule(function()
      vim.opt.clipboard = 'unnamedplus'
      if not has_native_clipboard() then
        local osc52 = require('vim.ui.clipboard.osc52')
        local function paste()
          return { vim.split(vim.fn.getreg('"'), '\n'), vim.fn.getregtype('"') }
        end
        vim.g.clipboard = {
          name = 'OSC 52 (copy-only)',
          copy  = { ['+'] = osc52.copy('+'), ['*'] = osc52.copy('*') },
          paste = { ['+'] = paste,           ['*'] = paste },
        }
      end
    end)
  end
end

M.setup_clipboard()

return M
