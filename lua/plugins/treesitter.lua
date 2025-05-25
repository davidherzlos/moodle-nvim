return {
  -- Treesitter configurarions.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "bash", "regex", "vim", "vimdoc", "lua", "luadoc", "markdown", "markdown_inline", "php", "html", "javascript", "typescript"},
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
      vim.treesitter.language.register('html', 'mustache')  -- the someft filetype will use the python parser and queries.
    end
  },
  -- Show the context of the current content as it is navigated.
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    config = function()
      require'treesitter-context'.setup{
        enable = true,
        multiwindow = true,
        line_numbers = false,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      }
    end
  }
}

