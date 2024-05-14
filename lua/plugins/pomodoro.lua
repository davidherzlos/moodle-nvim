return {
  -- Plugin for pomodoro timers.
  {
    "epwalsh/pomo.nvim",
    version = "*",  -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = {
      "TimerStart", "TimerRepeat"
    },
    dependencies = {
      -- Optional if you want to use the notification windows.
      "rcarriga/nvim-notify",
    },
    opts = {
    },
  }
}

