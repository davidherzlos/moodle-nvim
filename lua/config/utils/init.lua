---@diagnostic disable-next-line: undefined-field
local cwd = vim.loop.cwd()

-- Module for Project utils.
local M = {}

-- Returns true if Moodle core files exist.
local function _moodle_files_exist ()
  return vim.fn.filereadable(cwd .. '/lib/moodlelib.php') == 1 and true or false
end

-- Checks is the current project is Moodle.
function M.moodle_project()
  return _moodle_files_exist()
end

return M


