return {
  {
    -- MCP server: exposes editor state (open files, selection, diagnostics, diffs) to claudecode cli
    "coder/claudecode.nvim",
    event = "User SidekickCliAttach",
    opts = {
      log_level = "info", -- 'trace', 'debug', 'info', 'error'
      terminal = {
        -- Terminal provider is intentionally disabled (sidekick owns the terminal session)
        provider = 'none',
      },
      diff_opts = {
        layout = 'horizontal',
        open_in_new_tab = true,
        hide_terminal_in_new_tab = true,
      },
    },
    keys = {
      -- Context sharing.
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",    mode = "v", desc = "Add selection" },
      { "<leader>af", "<cmd>ClaudeCodeAdd %:p<cr>", desc = "Add file" },
      -- File tree: add selected file(s) to Claude context
      {
        "<leader>af",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  },
  {
    -- Terminal runs Claude Code CLI, watches modified files,
    -- and reloads buffers  when claudecode writes to disk.
    "folke/sidekick.nvim",
    dependencies = { "snacks.nvim" },
    opts = {
      cli = {
        watch = true,
        win = {
          layout = 'left',
          split = {
            width = 0.45,
          },
        },
      },
    },
    keys = {
      -- Terminal lifecycle
      { "<leader>at", function() require("sidekick.cli").toggle({ filter = { installed = true } }) end, desc = "Toggle agent" },
      { "<leader>as", function() require("sidekick.cli").select() end, desc = "Select agent" },
      { "<leader>aq", function() require("sidekick.cli").close() end,                                   desc = "Detach session" },
      { "<C-a>", function() require("sidekick.cli").focus() end, mode = { "t", "i", "x" }, desc = "Toggle focus" },
      { "<leader>ap", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Use a prompt" },
    },
  },
}
