return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              schema = {
                model = {
                  default = "deepseek-chat",
                },
                -- num_ctx = {
                --   default = 16384,
                -- },
                -- num_predict = {
                --   default = -1,
                -- },
              },
              env = {
                api_key = "sk-0c50024025784b418c5f63652fb68fff",
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "deepseek", },
          inline = { adapter = "deepseek" },
          agent = { adapter = "deepseek" },
        },
      })
    end,
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
  }
}
