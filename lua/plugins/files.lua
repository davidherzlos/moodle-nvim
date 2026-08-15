
return {
  -- Fast file search for large projects.
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      -- downloads a prebuilt binary or falls back to cargo build
      require("fff.download").download_or_build_binary()
    end,
    -- for nixos:
    -- build = "nix run .#release",
    opts = {
      prompt = '  ',
      title = 'FFFiles',
      -- max_results = 100,
      max_threads = 4,
      lazy_sync = true,
      prompt_vim_mode = true,
      layout = {
        height = 0.85,
        width = 0.8,
        prompt_position = 'top',   -- or 'top'
        preview_position = 'bottom',   -- 'left' | 'right' | 'top' | 'bottom'
        preview_size = 0,
        flex = { size = 130, wrap = 'top' },
        show_scrollbar = false,
        path_shorten_strategy = 'middle_number', -- 'middle_number' | 'middle' | 'end'
        anchor = 'bottom',
      },
      preview = {
        enabled = true,
        max_size = 10 * 1024 * 1024,
        chunk_size = 8192,
        binary_file_threshold = 1024,
        imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit',
        line_numbers = true,
        cursorlineopt = 'both',
        wrap_lines = false,
        filetypes = {
          svg = { wrap_lines = true },
          markdown = { wrap_lines = true },
          text = { wrap_lines = true },
        },
      },
      keymaps = {
        close = '<Esc>',
        select = { '<CR>', '<C-l>'},
        select_split = '<C-s>',
        select_vsplit = '<C-v>',
        select_tab = '<C-t>',
        move_up = { '<C-k>', '<C-p>' },
        move_down = { '<C-j>', '<C-n>' },
        preview_scroll_up = '<C-u>',
        preview_scroll_down = '<C-d>',
        toggle_debug = '<F2>',
        cycle_grep_modes = '<S-Tab>',
        cycle_previous_query = '<C-Up>',
        toggle_select = '<Tab>',
        send_to_quickfix = '<C-q>',
        focus_list = '<leader>l',
        focus_preview = '<leader>p',
      },
      frecency = {
        enabled = true,
        db_path = vim.fn.stdpath('cache') .. '/fff_nvim',
      },
      history = {
        enabled = true,
        db_path = vim.fn.stdpath('data') .. '/fff_queries',
        min_combo_count = 3,
        combo_boost_score_multiplier = 100,
      },
      git = {
        status_text_color = false, -- true to color filenames by git status
      },
      grep = {
        max_file_size = 10 * 1024 * 1024,
        max_matches_per_file = 100,
        smart_case = true,
        time_budget_ms = 150,
        modes = { 'plain', 'regex', 'fuzzy' },
        trim_whitespace = false,
      },
      debug = { enabled = false, show_scores = false },
      logging = {
        enabled = true,
        log_file = vim.fn.stdpath('log') .. '/fff.log',
        log_level = 'info',
      },

    },
    lazy = false, -- the plugin lazy-initialises itself
    keys = {
      { "<leader>fF", function() require('fff').find_files() end, desc = 'Find files (cwd)' },
      { "<leader>gG", function() require('fff').live_grep({ grep = { modes = { 'regex', 'plain', 'fuzzy' } } }) end, desc = 'Grep (cwd)', },
    },
  },
  {
    -- Files management the Vim way.
    'stevearc/oil.nvim',
    enabled = true,
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    lazy = false,
    config = function ()
      require("oil").setup({
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["<Esc>"] = { "actions.close", mode = "n" },
          ["<CR>"] = { "actions.select", mode = "n" }, -- Keep Enter as default
          ["l"] = { "actions.select", mode = "n" }, -- Use l for ergonomy
          ["h"] = "actions.parent",    -- Use 'h' to go up
        },
        float = {
          max_width = 0.85,
          border = 'single',
          max_height = 0.8,
          preview_split = 'right',
        },
      })
      vim.keymap.set("n", '<leader>fe', function() vim.cmd("Oil --float") end, { desc = "File explorer (oil.nvim)" })
    end
  },
}
