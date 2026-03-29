return {
  "rebelot/heirline.nvim",
  dependencies = { "zeioth/heirline-components.nvim" },
  event = "BufEnter",
  opts = function()
    local lib = require "heirline-components.all"
    local conditions = require("heirline.conditions")
    local ignored_file_types = {
      'dapui_watches',
      'dapui_stacks',
      'dapui_breakpoints',
      'dapui_scopes',
      'dapui_console',
      'dap-repl',
    }
    local ignored_buf_types = {
      'prompt',
    }
    return {
      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        lib.component.git_diff(),
        lib.component.file_info({
          provider = function (self)
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
          end,
          filetype = false
        }),
        lib.component.fill(),
        lib.component.lsp(),
        lib.component.compiler_state(),
        lib.component.virtual_env(),
        lib.component.cmd_info(),
        lib.component.nav({
          condition = function ()
            return not conditions.buffer_matches({ filetype = ignored_file_types, buftype = ignored_buf_types })
          end
        }),
      },
    }
  end,
  config = function(_, opts)
    local heirline = require("heirline")
    local heirline_components = require "heirline-components.all"

    heirline_components.init.subscribe_to_events()
    heirline.load_colors(heirline_components.hl.get_colors())
    heirline.setup(opts)
  end,
}
