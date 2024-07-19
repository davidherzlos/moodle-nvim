---@diagnostic disable-next-line: undefined-field
local cwd = vim.loop.cwd()

local php = {}

-- Returns true if the current project is a Moodle codebase.
php.is_moodle_codebase = function ()
  return vim.fn.filereadable(cwd .. '/lib/moodlelib.php') == 1 and true or false
end

-- Formatters config.
local conform = require("conform")

-- Map filetypes to formatter commands.
conform.formatters_by_ft = {
  sh = { "beautysh" },
  php = { php.is_moodle_codebase() and "phpcbf" or "php-cs-fixer" }
}

-- Override formatters behavior if needed.
conform.formatters = {
  beautysh = {
    prepend_args = {
      "--indent-size=2",
      "--force-function-style=paronly",
    },
  },
  ['php-cs-fixer'] = {
    args = {
      "fix",
      "$FILENAME",
      "--using-cache=no",
      "--rules=@Symfony",
      "--no-interaction",
      "--quiet",
    },
  },
}

-- Linters config.
local lint = require('lint')

-- Map filetypes to linters commands.
lint.linters_by_ft = {
  php = { "phpstan", "phpcs" }
}

-- Override formatters behavior if needed.
if php.is_moodle_codebase() then
  -- Moodle needs more memory so phpstan can work properly.
  table.insert(lint.linters.phpstan.args, '--memory-limit=500M')
end



