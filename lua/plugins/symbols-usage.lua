-- Define utility function for getting some colors.
local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

-- Define another for formatting the text returned by the LSP.
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

return {
  {
    'Wansmer/symbol-usage.nvim',
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    keys = {
      { '<leader>su', function() require('symbol-usage').toggle() end, desc = 'Symbol usage' },
    },
    config = function()
      -- hl-groups can have any name
      local dim = h('NonText').fg
      vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('Normal').bg, italic = false })
      vim.api.nvim_set_hl(0, 'SymbolUsageContent', { fg = dim, italic = false })
      vim.api.nvim_set_hl(0, 'SymbolUsageRef',     { fg = dim, italic = false })
      vim.api.nvim_set_hl(0, 'SymbolUsageDef',     { fg = dim, italic = false })
      vim.api.nvim_set_hl(0, 'SymbolUsageImpl',    { fg = dim, italic = false })

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
    end
  },
}

