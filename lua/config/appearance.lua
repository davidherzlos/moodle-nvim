-- All configs related with tweaking the ui apperance.

-- Configure editor signs and virtual text behavior for diagnostic messages.
vim.diagnostic.config{
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " 󰞏",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    }
  },
}

-- Custmize telescope highlights.
local tokyonight = require('tokyonight.config')
tokyonight.options.on_highlights = function(hl, c)
  local prompt = c.bg
  hl.TelescopeNormal = {
    bg = c.bg,
    fg = c.fg,
  }
  hl.TelescopeBorder = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
    hl.CursorLine = {
      bg = c.bg
    }
    hl.MiniIndentscopeSymbol = {
      fg = "#515a81"
    }
end

-- Customize signs for Debugging.
vim.api.nvim_set_hl(0, 'DapBreakPoint', { ctermbg = 0, fg = '#db4b4b', bg = '#2c0f0f' })
vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#e0af68', bg = '#2d2315' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#1abc9c', bg = '#05261f' })
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakPoint", linehl = "DapBreakPoint", numhl = "DapBreakPoint"})
vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint"})
vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped"})

-- Gitsigns highlights
vim.api.nvim_set_hl(0, 'GitSignsAddLn', { ctermbg = 0, bg = '#1a282e' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { ctermbg = 0, bg = '#1a282e' })
vim.api.nvim_set_hl(0, 'GitSignsStagedAddLn', { ctermbg = 0, bg = '#132a40' })
vim.api.nvim_set_hl(0, 'GitSignsStagedChangeLn', { ctermbg = 0, bg = '#132a40' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteVirtLn', { ctermbg = 0, bg = '#301014' })
vim.api.nvim_set_hl(0, 'GitSignsStagedChangedeleteLn', { ctermbg = 0, bg = '#301026' })
