local M = {}

M.definitions = {}

M.definitions.telescope_inspired_horizontal = {
  reverse = false,
  layout = {
    box = "vertical",
    backdrop = false,
    width = 0.85,
    height = 0.85,
    border = "none",
    {
      win = "input",
      height = 1,
      border = {  '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      title = "{title} {live} {flags}",
      title_pos = "center"
    },
    {
      box = "horizontal",
      {
        win = "list",
        title = " Results ",
        title_pos = "center",
        border = {  '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      },
      {
        win = "preview",
        title = "{preview:Preview}",
        width = 0.55,
        border = {  '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        title_pos = "center",
        wo = {
          wrap = false,
          number = true,
          signcolumn = "no",
        }
      },
    },
  },
}

M.definitions.telescope_inspired_vertical = {
  reverse = false,
  layout = {
    box = "vertical",
    backdrop = false,
    width = 0.85,
    height = 0.85,
    border = "none",
    {
      win = "input",
      height = 1,
      border = {  '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      title = "{title} {live} {flags}",
      title_pos = "center"
    },
    {
      box = "vertical",
      {
        win = "list",
        title = " Results ",
        title_pos = "center",
        border = {  '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      },
      {
        win = "preview",
        title = "{preview:Preview}",
        border = {  '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        title_pos = "center",
        wo = {
          wrap = false,
          number = true,
          signcolumn = "no",
        }
      },
    },
  },
}

return M
