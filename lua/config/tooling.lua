-- Define config to allow Neovim to user tooling.
local utils = require('config.utils')
local M = {}

-- Add here any custom config to formatters.
local formatters = {}
formatters['beautysh'] = {
  prepend_args = {
    '--indent-size=2',
    '--force-function-style=paronly',
  },
}
formatters['phpcs'] = {}
formatters['php-cs-fixer'] = {
  command = 'php-cs-fixer',
  args = {
    'fix',
    '$FILENAME',
    '--using-cache=no',
    '--rules=@Symfony',
    '--no-interaction',
    '--quiet',
  },
}
formatters['biome'] = {}
formatters['stylua'] = {}
formatters['typescript-language-server'] = {}

-- Add here any custom config to linters.
local linters = {}

linters['phpcs'] = {}
linters['phpstan'] = {}
linters['biome'] = {}
linters['selene'] = {}

-- Export filetype mappings for formatters.
function M.formatters_by_ft()
  return {
    sh = { 'beautysh' },
    php = { utils.is_moodle_project() and 'phpcbf' or 'php-cs-fixer' },
    javascript = { 'biome' },
    json = { 'biome' },
    lua = { 'stylua' },
  }
end

-- Export filetype mappings for linters.
function M.linters_by_ft()
  return {
    php = { 'phpcs' },
    javascript = { 'biome' },
    json = { 'biome' },
    typescript = { 'typescript-language-server' },
    lua = { 'selene' },
  }
end

-- Export the tools names.
function M.export_names()
  local seen = {}
  local tools = {}
  for _, name in ipairs(vim.tbl_keys(formatters)) do
    if not seen[name] then
      seen[name] = true
      table.insert(tools, name)
    end
  end
  for _, name in ipairs(vim.tbl_keys(linters)) do
    if not seen[name] then
      seen[name] = true
      table.insert(tools, name)
    end
  end
  return tools
end

-- Export formatters specs for configuration.
function M.export_formatters_specs()
  local specs = {}
  for key, spec in pairs(formatters) do
    if not vim.tbl_isempty(spec) then
      specs[key] = spec
    end
  end
  return specs
end

return M
