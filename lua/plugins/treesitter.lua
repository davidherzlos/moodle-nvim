return {
  -- Treesitter configurarions.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function ()
      -- Add parsers for supported languages.
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "bash", "regex", "vim", "vimdoc", "lua", "luadoc", "markdown", "markdown_inline", "php", "html", "javascript", "typescript" },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 512 * 1024 -- 512 KB
            local ok, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
          end,
        },
        indent = {
          enable = true
        },
      })
      -- Add external parsers.
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      -- parser_config.mustache = {
      --   install_info = {
      --     url = "https://github.com/TheLeoP/tree-sitter-mustache.git", -- local path or git repo
      --     files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
      --     -- optional entries:
      --     branch = "main", -- default branch in case of git repo if different from master
      --     generate_requires_npm = true, -- if stand-alone parser without npm dependencies
      --     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
      --   },
      --   filetype = "mustache", -- if filetype does not match the parser name
      -- }
      vim.treesitter.language.register('html', 'mustache')  -- the someft filetype will use the python parser and queries.
    end
  },
  -- Show the context of the current content as it is navigated.
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    config = function()
      require'treesitter-context'.setup{
        enable = false,
        multiwindow = true,
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      }
      vim.keymap.set("n", "{{", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true })
    end
  },
  {
    "dkendal/nvim-treeclimber",
    config = function()
      require('nvim-treeclimber').setup()
    end,
    keys = {
      -- Core navigation
      { "<C-h>", "<Plug>(treeclimber-select-parent)", mode = { "x", "o" }, desc = "Select parent node" },
      { "<C-j>", "<Plug>(treeclimber-select-next)", mode = { "x", "o" }, desc = "Select next node" },
      { "<C-k>", "<Plug>(treeclimber-select-previous)", mode = { "x", "o" }, desc = "Select previous node" },
      { "<C-l>", "<Plug>(treeclimber-select-shrink)", mode = { "x", "o" }, desc = "Select child node" },

      -- Growth selection
      { "K", "<Plug>(treeclimber-select-grow-backward)", mode = { "x", "o" }, desc = "Grow selection backward" },
      { "J", "<Plug>(treeclimber-select-grow-forward)", mode = { "x", "o" }, desc = "Grow selection forward" },

      -- Visual/operator mode specific
      { "I", "<Plug>(treeclimber-select-current-node)", mode = { "x", "o" }, desc = "Select current node (inner)" },
      { "A", "<Plug>(treeclimber-select-expand)", mode = { "x", "o" }, desc = "Select parent node (around)" },
    },
    cmd = { "TCDiffThis", "TCShowControlFlow", "TCHighlightExternalDefinitions" },
  },
}

