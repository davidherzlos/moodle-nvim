return {
  {
    -- Let neovim understand the structure of your document.
    "nvim-treesitter/nvim-treesitter",
    commit = 'c579d18',
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "bash", "regex", "vim", "vimdoc", "lua", "luadoc", "php", "markdown", "markdown_inline" },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          -- Use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 2000 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
          end,
        },
        indent = {
          enable = true
        },
      })
    end
  }
}

