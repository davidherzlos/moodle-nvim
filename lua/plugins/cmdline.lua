return {
  -- Plugin for helix style cmdline.
  {
    'vzze/cmdline.nvim',
    config = function ()
      require('cmdline').setup({
        cmdtype = ":", -- you can also add / and ? by using ":/?"
        window = {
          matchFuzzy = false,
          offset     = 1,    -- depending on 'cmdheight' you might need to offset
          debounceMs = 10    -- the lower the number the more responsive however
        },
        hl = {
          default   = "WhichKeyGroup",
          selection = "PmenuSel",
          directory = "Directory",
          substr    = "LineNr"
        },
        column = {
          maxNumber = 5,
          minWidth  = 20
        },
        binds = {
          next = "<Tab>",
          back = "<S-Tab>"
        }
      })
    end
  },
}
