local term = require('config.terminal')
local utils = require('config.utils')

-- Formatting and linting commands.

-- Add usercmd to toggle format on save.
vim.api.nvim_create_user_command("ConformToggle", function ()
  local state = vim.g.formatters_enabled
  vim.g.formatters_enabled = not state
  vim.notify('Conform ' .. (vim.g.formatters_enabled and 'enabled' or 'disabled') .. '.')
end, { desc = "Toggle formatting for the current buffer." })

-- Add a usercmd to print available linters for this buffer.
vim.api.nvim_create_user_command("LintInfo", function ()
  local lint = require('lint')
  local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
  local linters_str = ''
  for _, value in ipairs(linters) do
    linters_str = linters_str .. value .. ' '
  end
  if linters_str == '' then
    vim.print("No active linters." )
    return
  end
  vim.print("Active linters: " .. linters_str)
end, { desc = "Show availble linters for this buffer." })

-- Terminal related commands.

-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("TermOpen", function ()
  term.open_term()
  vim.cmd("startinsert")
end, {})

-- Moodle related commands.

-- Run Moodle Psysh repl.
vim.api.nvim_create_user_command("MoodlePsysh", function ()
  term.open_term()
  vim.cmd("startinsert")
  local job_id = vim.bo.channel
  vim.fn.chansend(job_id, "php -d xdebug.mode=off vendor/bin/psysh\n")
end, { desc = "Moodle run Psysh" })

-- Run Moodle Claude Code
vim.api.nvim_create_user_command("MoodleAgent", function ()
  require('sidekick.cli').toggle({ name = 'claude', focus = true })
end, { desc = "Moodle run Agent" })

-- Run Moodle test buffer.
-- TODO: validate test file before running.
vim.api.nvim_create_user_command("MoodleTestBuffer", function ()
  local relative_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
  term.open_term()
  vim.cmd("startinsert")
  local job_id = vim.bo.channel
  vim.fn.chansend(job_id, "php -d xdebug.mode=off vendor/bin/phpunit " .. relative_path .. " --color=always\n")
end, { desc = "Moodle run TestBuffer" })

-- Run Moodle test path.
-- TODO: validate test path before running.
vim.api.nvim_create_user_command("MoodleTestPath", function (opts)
  local test_path = opts.args ~= "" and opts.args or nil
  if test_path then
    term.open_term()
  vim.cmd("startinsert")
    local job_id = vim.bo.channel
    vim.fn.chansend(job_id, "php -d xdebug.mode=off vendor/bin/phpunit " .. test_path .. " --color=always --test-suffix '_test.php'\n")
    return
  end

  -- Parameter was not passed, so receive it with an input.
  vim.ui.input({ prompt = "TestsPath:"}, function (input)
    if not input or input == "" then
      vim.notify("No path provided", vim.log.levels.WARN)
      return
    end
    term.open_term()
    vim.cmd("startinsert")
    local job_id = vim.bo.channel
    vim.fn.chansend(job_id, "php -d xdebug.mode=off vendor/bin/phpunit " .. input .. " --color=always --test-suffix '_test.php'\n")
  end)

end, { nargs = "?", complete = 'file', desc = "Moodle run TestDir" })

-- Run Moodle test suite.
vim.api.nvim_create_user_command("MoodleTestSuite", function (opts)
  local component = opts.args ~= "" and opts.args or nil

  -- Parameter was passed from the cmdline.
  -- TODO: validate component exists.(needs component discovery feature or indexing)
  if component then
    term.open_term()
    vim.cmd("startinsert")
    local job_id = vim.bo.channel
    local run_cmd = "php -d xdebug.mode=off vendor/bin/phpunit --testsuite=" .. component .. "_testsuite --color=always\n"
    vim.fn.chansend(job_id, run_cmd)
    return
  end

  -- Parameter was not passed, so receive it with an input.
  vim.ui.input({ prompt = "TestSuite:"}, function (input)
    if not input or input == "" then
      vim.notify("No component provided", vim.log.levels.WARN)
      return
    end
    term.open_term()
    vim.cmd("startinsert")
    local job_id = vim.bo.channel
    local run_cmd = "php -d xdebug.mode=off vendor/bin/phpunit --testsuite=" .. input .. "_testsuite --color=always\n"
    vim.fn.chansend(job_id, run_cmd)
  end)

end, { nargs = "?", desc = "Moodle run TestSuite" })

-- Add a usercmd to purge Moodle cache.
vim.api.nvim_create_user_command("MoodlePurgeCaches", function ()
  term.open_term()
  vim.cmd("startinsert")
  local job_id = vim.bo.channel
  local run_cmd = "php -d xdebug.mode=off admin/cli/purge_caches.php\n"
  vim.fn.chansend(job_id, run_cmd)
end, { desc = "Purge Moodle caches" })

-- Add a usercmd to run the Moodle upgrade script with no user interaction.
vim.api.nvim_create_user_command("MoodleUpgrade", function ()
  term.open_term()
  vim.cmd("startinsert")
  local job_id = vim.bo.channel
  local run_cmd = "php -d xdebug.mode=off admin/cli/upgrade.php --non-interactive\n"
  vim.fn.chansend(job_id, run_cmd)
end, { desc = "Upgrade Moodle non Interactive" })

-- Add a usercmd to run the Moodle cron all jobs.
vim.api.nvim_create_user_command("MoodleCron", function ()
  term.open_term()
  vim.cmd("startinsert")
  local job_id = vim.bo.channel
  local run_cmd = "php -d xdebug.mode=off admin/cli/cron.php\n"
  vim.fn.chansend(job_id, run_cmd)
end, { desc = "Moodle Cron" })

-- Add a usercmd to run the Grunt compile Javascript.
vim.api.nvim_create_user_command("MoodleCompileJS", function ()
  local git_root = utils.git_root({ relative = true })
  if not git_root or git_root == "" then
    vim.notify("No git root found")
    return
  end
  term.open_term()
  vim.cmd("startinsert")
  local job_id = vim.bo.channel
  local run_cmd = "grunt --fix --root=" .. git_root .. " --force\n"
  vim.fn.chansend(job_id, run_cmd)
end, { desc = "Compile JS Modules" })

--Add a usercmd to run phpstan for the given buffer.
vim.api.nvim_create_user_command('PhpStan', function ()
  vim.notify("Running phpstan")
  require('config.phpstan.lint').try_lint()
end, { desc = "Run phpstan for the given php file" })
