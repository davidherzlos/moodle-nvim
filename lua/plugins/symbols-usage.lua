-- Define utility function for getting some colors.
local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

-- And add another longer for formatting the text returned by the LSP.
local function text_format(symbol)
  local res = {}

  local round_start = { '', 'SymbolUsageRounding' }
  local round_end = { '', 'SymbolUsageRounding' }

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions_content = symbol.stacked_count > 0
  and ("+%s"):format(symbol.stacked_count)
  or ''

  if symbol.references then
    local usage = symbol.references <= 1 and 'reference' or 'references'
    local num = symbol.references == 0 and 'no' or symbol.references
    table.insert(res, round_start)
    table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
    table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, round_start)
    table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
    table.insert(res, { symbol.definition .. ' defined', 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, round_start)
    table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
    table.insert(res, { symbol.implementation .. ' implemented', 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  if stacked_functions_content ~= '' then
    if #res > 0 then
      table.insert(res, { ' ', 'NonText' })
    end
    table.insert(res, round_start)
    table.insert(res, { ' ', 'SymbolUsageImpl' })
    table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
    table.insert(res, round_end)
  end

  return res
end
-- Now install and configure the plugins for symbols usage.
return {
  {
    'Wansmer/symbol-usage.nvim',
    dependencies = {
      "neovim/nvim-lspconfig", -- Just ensure Lsp setup is finished.
    },
    keys = {
      '<leader>st',
    },
    config = function()
      -- hl-groups can have any name
      vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = h('CursorLine').bg, fg = h('Comment').fg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
      vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })

      local SymbolKind = vim.lsp.protocol.SymbolKind
      require('symbol-usage').setup({
        vt_position = 'above',
        kinds = {
          SymbolKind.Interface,
          SymbolKind.Class,
          SymbolKind.Constructor,
          SymbolKind.Function,
          SymbolKind.Method,
        },
        text_format = text_format,
        request_pending_text = '...',
        references = { enabled = true, include_declaration = true },
        definition = { enabled = true },
        implementation = { enabled = true },
      })
      vim.keymap.set('n', '<leader>su', function() require('symbol-usage').toggle() end, { desc = 'Symbols Usage: [S]ymbols [To]ggle' })
    end
  },
}

