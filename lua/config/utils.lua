---@diagnostic disable-next-line: undefined-field
local cwd = vim.loop.cwd()

-- Utils module.
local M = {}

local function _moodle_root_markers_exists()
  local setup = vim.fn.filereadable(cwd .. '/lib/setup.php')
  local config = vim.fn.filereadable(cwd .. '/config.php')
  local composer = vim.fn.filereadable(cwd .. '/composer.json')
  local package = vim.fn.filereadable(cwd .. '/package.json')

  return (setup ==  1 and config == 1 and composer == 1 and package == 1) and true or false
end

local function _get_neovim_plugins_path()
  return vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
end

local function _get_neovim_config_path()
    return vim.fn.stdpath('config')
end

local function _get_git_root(opts)
  local git_root = Snacks.git.get_root()
  if not git_root then
    return nil
  end 

  if opts.relative then
    return git_root:gsub("^/var/www/html/?", "")
  end
  return git_root
end

local function _get_running_php_version()
if vim.fn.executable("php") == 0 then
    return nil
  end
  local obj = vim.system({ "php", "-r", "echo PHP_VERSION;" }, { text = true }):wait()
  if obj.code ~= 0 then
    return nil
  end
  return vim.trim(obj.stdout)
end


-- Export the Module's public API.

-- Returns true if Moodle core files can be reached.
function M.is_moodle_project()
  return _moodle_root_markers_exists()
end

-- Returns the plugins path.
function M.plugins_path()
  return _get_neovim_plugins_path()
end

-- Returns the config path.
function M.config_path()
  return _get_neovim_config_path()
end

-- Returns the nearest git root for the current buffer.
-- TODO: need to be re-implemented.
function M.git_root(opts)
  opts = opts or {}
  opts.relative = opts.relative or false
  return _get_git_root(opts)
end

-- Get the php version installed, returns latest stable version as default.
function M.get_php_version()
  local version = _get_running_php_version()
  if version == nil then
    return "8.5.0"
  end
  return version
end

-- Get the project root markers for php development.
function M.get_project_root_markers()
  if _moodle_root_markers_exists() == true then
    return { 'config-dist.php', 'config.php', 'composer.json' }
  end
  return { '.git', 'composer.json' }
end

return M


