return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      notifier = { enabled = true },
      rename = { enabled = true },
      git = { enabled = true },
      statuscolumn = {
        enabled = true,
        right = { "mark", "sign" }, -- priority of signs on the left (high to low)
        left = { "fold", "git" }, -- priority of signs on the right (high to low)
      },
      words = { enabled = true },
      scratch = {
        enabled = true,
        win = {
          backdrop = 100,
        }
      },
    },
    keys = {
      { "<C-f>", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n" }},
      { "<C-b>", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n" }},
      { "<leader>..",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>.l",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>rf", function() Snacks.rename.rename_file() end, desc = "LSP:[R]ename [F]ile" },
    },
  }
}
