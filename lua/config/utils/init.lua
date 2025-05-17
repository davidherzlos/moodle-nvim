---@diagnostic disable-next-line: undefined-field
local cwd = vim.loop.cwd()

-- Utils module.
local M = {}

-- Returns true if Moodle core files can be reached.
local function _moodle_files_exist()
  return vim.fn.filereadable(cwd .. '/lib/moodlelib.php') == 1 and true or false
end

-- Returns the plugins path.
local function _get_neovim_plugins_path()
  return vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
end

-- Returns the config path.
local function _get_neovim_config_path()
    return vim.fn.stdpath('config')
end

-- Returns the nearest git root for the current buffer.
local function _get_git_root()
  return Snacks.git.get_root()
end

-- Returns the relative path of the nearest git root.
local function _get_git_root_relative()
      local git_root = Snacks.git.get_root() -- Get the file's directory.
      local relative_dir = vim.fn.fnamemodify(git_root, ':~:.')..'/'
end

-- Export the Module's API.

function M.is_moodle_project()
  return _moodle_files_exist()
end

function M.plugins_path()
  return _get_neovim_plugins_path()
end

function M.config_path()
  return _get_neovim_config_path()
end

function M.git_root()
  return _get_git_root()
end

return M


