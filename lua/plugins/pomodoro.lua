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
      "rcarriga/nvim-notify",
    },
    opts = {
    },
  }
}

