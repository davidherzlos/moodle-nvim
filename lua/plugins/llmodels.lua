return 
  {
    -- Augment code.
    { 
      'augmentcode/augment.vim',
      enabled = true,
      config = function ()
        -- Add the current working dir the folders augment index.
        vim.g.augment_workspace_folders = {
          vim.loop.cwd()
        }

        -- Disable completions by default.
        vim.g.augment_disable_completions = true
      end
    },
  }
