local custom_layouts = require('config.custom_layouts')
return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('snacks').setup({
        notifier = {
          enabled = true,
          style = 'compact',
          top_down = false,
          margin = { top = 0, right = 2, bottom = 0 },
          icons = {
            error = ' ',
            warn = ' ',
            info = ' ',
            debug = ' ',
            trace = ' ',
          },
        },
        rename = {
          enabled = true,
        },
        git = {
          enabled = true,
        },
        statuscolumn = {
          enabled = true,
          right = { 'mark', 'sign' },
          left = { 'fold', 'git' },
        },
        input = {
          enabled = true,
        },
        picker = {
          enabled = true,
          layouts = custom_layouts.definitions,
          win = {
            input = {
              keys = {
                ['<Down>'] = { 'history_forward', mode = { 'i', 'n' } },
                ['<Up>'] = { 'history_back', mode = { 'i', 'n' } },
                ['<C-l>'] = { 'confirm', mode = { 'n', 'i' } },
                ['<c-u>'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
                ['<c-d>'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
                ['<c-b>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
                ['<c-f>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
              },
            },
          },
          formatters = {
            file = {
              truncate = 'center',
            },
          },
        },
        words = {
          enabled = true,
        },
        scratch = {
          enabled = true,
          win = {
            position = 'float',
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            backdrop = 100,
            height = 0.8,
            width = 0.8,
          },
        },
      })

      local picker_cfg = function (source)
        local utils = require('config.utils')

        source = source ~= '' and source or nil
        local picker_options = {
          layout = 'telescope_inspired_vertical',
        }

        if source == 'closest' then
          local closest_path = utils.get_plugin_root()
          if closest_path ~= (vim.uv or vim.loop).cwd() then
            picker_options.cwd = vim.fn.fnamemodify(closest_path, ":h")
            picker_options.dirs = { closest_path }
            picker_options.title = "Closest: " .. vim.fn.fnamemodify(closest_path, ":.")
          end
        end

        if source == 'config' then
          local config_path = utils.config_path()
          picker_options.cwd = vim.fn.fnamemodify(config_path, ":h")
          picker_options.dirs = { config_path }
          picker_options.title = "Config: " .. vim.fn.fnamemodify(config_path, ":.")
        end

        if source == 'plugins' then
          local plugins_path = utils.plugins_path()
          picker_options.cwd = vim.fn.fnamemodify(plugins_path, ":h")
          picker_options.dirs = { plugins_path }
          picker_options.title = "Plugins: " .. vim.fn.fnamemodify(plugins_path, ":.")
        end

        return picker_options
      end

      vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files(picker_cfg()) end, { desc = 'Find files (cwd)' })
      vim.keymap.set('n', '<leader>f.', function() Snacks.picker.files(picker_cfg('closest')) end, { desc = 'Find files (project)' })
      vim.keymap.set('n', '<leader>fc', function() Snacks.picker.files(picker_cfg('config')) end, { desc = 'Find files (config)' })
      vim.keymap.set('n', '<leader>fp', function() Snacks.picker.files(picker_cfg('plugins')) end, { desc = 'Find files (plugins)' })
      vim.keymap.set('n', '<leader>fl', function() Snacks.picker.recent(picker_cfg()) end, { desc = 'Find files (last open)' })
      vim.keymap.set('n', '<leader>gg', function() Snacks.picker.grep(picker_cfg()) end, { desc = 'Grep (cwd)' })
      vim.keymap.set('n', '<leader>g.', function() Snacks.picker.grep(picker_cfg('closest')) end, { desc = 'Grep (project)' })
      vim.keymap.set('n', '<leader>gc', function() Snacks.picker.grep(picker_cfg('config')) end, { desc = 'Grep (config)' })
      vim.keymap.set('n', '<leader>gp', function() Snacks.picker.grep(picker_cfg('plugins')) end, { desc = 'Grep (plugins)' })
      vim.keymap.set('n', '<leader>gw', function() Snacks.picker.grep_word(picker_cfg()) end, { desc = 'Grep (word on cursor)' })
      vim.keymap.set('n', '<leader>sl', function() Snacks.picker.lines() end, { desc = 'Search lines' })
      vim.keymap.set('n', '<C-f>', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Ref' })
      vim.keymap.set('n', '<C-b>', function() Snacks.words.jump(-(vim.v.count1 + 1)) end, { desc = 'Prev Ref' })
      vim.keymap.set('n', '<leader>..', function() Snacks.scratch() end, { desc = 'Scratch buffer' })
      vim.keymap.set('n', '<leader>.l', function() Snacks.scratch.select() end, { desc = 'List scratches' })
      vim.keymap.set('n', '<leader>rf', function() Snacks.rename.rename_file() end, { desc = 'Rename file' })
    end,
  },
}
