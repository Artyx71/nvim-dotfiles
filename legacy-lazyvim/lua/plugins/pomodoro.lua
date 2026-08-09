return {
  -- ── Pomodoro — 45 min work / 15 min break ─────────────────────────
  -- <leader>Ps → старт | <leader>Pp → пауза/резюм | <leader>Pr → сброс
  -- Статус в statusline: 🍅 44:59 (работа) | ☕ 14:59 (перерыв)

  -- Keybinds
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>P",  group = "Pomodoro", icon = "🍅" },
        { "<leader>Ps", desc  = "Старт",    icon = "▶" },
        { "<leader>Pp", desc  = "Пауза / Резюм", icon = "⏸" },
        { "<leader>Pr", desc  = "Сброс",    icon = "↺" },
      },
    },
    keys = {
      { "<leader>Ps", function() require("config.pomodoro").start() end,  desc = "Pomodoro: старт" },
      { "<leader>Pp", function() require("config.pomodoro").pause() end,  desc = "Pomodoro: пауза/резюм" },
      { "<leader>Pr", function() require("config.pomodoro").reset() end,  desc = "Pomodoro: сброс" },
    },
  },

  -- Lualine component
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local pomodoro_component = {
        function()
          return require("config.pomodoro").status()
        end,
        cond = function() return true end,
      }

      -- добавляем в правую часть statusline (перед clock/location)
      table.insert(opts.sections.lualine_x, 1, pomodoro_component)

      return opts
    end,
  },
}
