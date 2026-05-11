-- Lua module to open a customized terminal.
local M = {}

local function _detect_shell()

  -- First try the $SHELL environment variable
  local env_shell = (vim.uv or vim.loop).os_getenv("SHELL") or ""

  -- Clean up whitespace/newlines
  env_shell = env_shell:gsub("%s+", "")

  -- If $SHELL is set and valid, use it
  if env_shell ~= "" then
    local shell_name = env_shell:match("[^/]+$") or ""
    return env_shell, shell_name
  end

  -- Fallback: try to find common shells in order of preference
  local common_shells = {
    {"/bin/bash", "bash"},
    {"/usr/bin/bash", "bash"},
    {"/usr/local/bin/bash", "bash"},
    {"/bin/zsh", "zsh"},
    {"/usr/bin/zsh", "zsh"},
    {"/usr/local/bin/zsh", "zsh"}
  }

  for _, shell_info in ipairs(common_shells) do
    local shell_path, shell_name = shell_info[1], shell_info[2]
    local stat = (vim.uv or vim.loop).fs_stat(shell_path)
    if stat and stat.type == "file" then
      return shell_path, shell_name
    end
  end

  -- Last resort: check current process
  local handle = io.popen("ps -p $$ -o comm=")
  local proc_shell = handle and handle:read("*a") or ""
  if handle then handle:close() end
  proc_shell = proc_shell:gsub("%s+", "")

  return proc_shell, proc_shell
end

-- Create a terminal in a vertical split window.
local function _open_terminal()
  -- Detect shell
  local shell_path, shell_name = _detect_shell()

  -- Choose the correct flags for interactive shell with config loaded
  local flags = "-i"
  if shell_name == "bash" then
    flags = "--login"
  elseif shell_name == "zsh" then
    flags = "-i"
  end

  -- Apply shell settings only for our terminal commands, not globally
  -- This preserves compatibility with other plugins like claude-code
  vim.g.detected_shell_path = shell_path
  vim.g.detected_shell_flags = flags
  vim.cmd.new()

  -- Use detected shell for this terminal only
  if vim.g.detected_shell_path and vim.g.detected_shell_path ~= "" then
    vim.cmd("terminal " .. vim.g.detected_shell_path .. " " .. vim.g.detected_shell_flags)
  else
    vim.cmd.terminal()
  end

  -- Position the terminal to the left.
  vim.cmd.wincmd("J")

  -- Calculate 40% of total lines for terminal height
  local terminal_height = math.floor(vim.o.lines * 0.4)
  vim.api.nvim_win_set_height(0, terminal_height)
end

M.open_term = function ()
  _open_terminal()
  vim.cmd("startinsert")
end

return M
