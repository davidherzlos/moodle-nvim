return {
  "adriankarlen/buffed.nvim",
  enabled = true,
  dependencies = {
    "echasnovski/mini.icons" ,
    "stevearc/dressing.nvim",
  }, -- optional: required for file icons
  opts = {
    filters = {
      -- create a group of buffers that are currently modified
      modified = {
        icon = "",
        hl = "DiagnosticWarn",
        fun = function(bufnr)
        end,
      },
    },
  },
  config = function ()
    -- example usage as a picker using vim.ui.select
    vim.keymap.set("n", "<leader>fb", function()
      vim.ui.select(require("buffed").get("modified"), { prompt = "select modified" }, function(selection)
        vim.cmd.edit(selection)
      end)
    end, { desc = "pick modified" })
  end
}
