return {
  {
    -- MCP server: exposes editor state (open files, selection, diagnostics, diffs) to claudecode cli
    'coder/claudecode.nvim',
    event = 'User SidekickCliAttach',
    opts = {
      log_level = 'info', -- 'trace', 'debug', 'info', 'error'
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
      -- Diff management
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },
  {
    -- Terminal runs Claude Code CLI, watches modified files,
    -- and reloads buffers  when claudecode writes to disk.
    'folke/sidekick.nvim',
    dependencies = { 'snacks.nvim' },
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
      {
        '<C-a>',
        function()
          require('sidekick.cli').toggle({ filter = { installed = true } })
        end,
        mode = { 'n', 't', 'i', 'x' },
        desc = 'Agents list',
      },
      {
        '<C-s>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 't', 'i', 'x' },
        desc = 'Switch focus',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Prompt templates',
      },
      {
        "<leader>al",
        function() require("sidekick.cli").send({ msg = "{position}" }) end,
        mode = { 'x' },
        desc = "Add lines to prompt",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Add file to prompt",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Add selection to prompt",
      },
      {
        "<leader>ab",
        function() require("sidekick.cli").send({ msg = "{buffers}" }) end,
        desc = "Add buffers to prompt",
      },
    },
  },
}
