return {
  {
    'vimiomori/pomodoro.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function()
      require('pomodoro').setup({
        time_work = 35,
        time_break_short = 5,
        time_break_long = 15,
        timers_to_long_break = 4
      })
    end,
    keys = {
      { "<leader>pp", "<cmd>PomodoroStart<cr>", desc = "Start Pomodoro" },
      { "<leader>pd", "<cmd>PomodoroStop<cr>", desc = "Stop Pomodoro" },
    },
  }
}

