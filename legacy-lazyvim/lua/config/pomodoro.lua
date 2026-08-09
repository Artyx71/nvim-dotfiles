-- Pomodoro timer — 45 min work / 15 min break
-- Start: <leader>Ps | Pause: <leader>Pp | Reset: <leader>Pr

local M = {}

local WORK_SECS  = 45 * 60
local BREAK_SECS = 15 * 60

local state = {
  running   = false,
  mode      = "work",   -- "work" | "break"
  remaining = WORK_SECS,
  session   = 0,
  timer     = nil,
  blocker   = nil,      -- float win handle
}

-- ── helpers ────────────────────────────────────────────────────────

local function fmt(secs)
  return string.format("%02d:%02d", math.floor(secs / 60), secs % 60)
end

local function notify(msg, level)
  vim.schedule(function()
    vim.notify(msg, level or vim.log.levels.INFO, { title = "Pomodoro" })
  end)
end

-- ── blocker window ─────────────────────────────────────────────────

local function open_blocker()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  local lines = {
    "",
    "  ☕  ПЕРЕРЫВ  ☕  ",
    "",
    "  Отойди от экрана.",
    "  Потянись. Попей воды.",
    "",
    "  Осталось: " .. fmt(state.remaining),
    "",
    "  [q] закрыть (таймер продолжается)",
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  local w = 44
  local h = #lines
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width    = w,
    height   = h,
    col      = math.floor((vim.o.columns - w) / 2),
    row      = math.floor((vim.o.lines - h) / 2),
    style    = "minimal",
    border   = "rounded",
    zindex   = 200,
  })

  vim.api.nvim_buf_set_keymap(buf, "n", "q",
    "<cmd>lua require('config.pomodoro').close_blocker()<cr>",
    { noremap = true, silent = true })

  state.blocker = { win = win, buf = buf }
end

function M.close_blocker()
  if state.blocker and vim.api.nvim_win_is_valid(state.blocker.win) then
    vim.api.nvim_win_close(state.blocker.win, true)
  end
  state.blocker = nil
end

local function update_blocker()
  if not state.blocker then return end
  if not vim.api.nvim_win_is_valid(state.blocker.win) then
    state.blocker = nil
    return
  end
  local buf = state.blocker.buf
  vim.bo[buf].modifiable = true
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  lines[7] = "  Осталось: " .. fmt(state.remaining)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
end

-- ── tick ───────────────────────────────────────────────────────────

local function tick()
  if not state.running then return end

  state.remaining = state.remaining - 1

  if state.remaining <= 0 then
    if state.mode == "work" then
      state.session  = state.session + 1
      state.mode     = "break"
      state.remaining = BREAK_SECS
      notify("🍅 Работа завершена! Сессия #" .. state.session .. ". Время отдохнуть.", vim.log.levels.WARN)
      vim.schedule(open_blocker)
    else
      state.mode     = "work"
      state.remaining = WORK_SECS
      notify("☕ Перерыв окончен! Пора работать.", vim.log.levels.INFO)
      M.close_blocker()
    end
  else
    update_blocker()
  end
end

-- ── public API ─────────────────────────────────────────────────────

function M.start()
  if state.running then return end
  state.running = true
  if not state.timer then
    state.timer = vim.loop.new_timer()
    state.timer:start(1000, 1000, vim.schedule_wrap(tick))
  end
  notify("▶ Pomodoro запущен — " .. (state.mode == "work" and "работа" or "перерыв") .. " " .. fmt(state.remaining))
end

function M.pause()
  if not state.running then
    M.start()
    return
  end
  state.running = false
  notify("⏸ Pomodoro на паузе — " .. fmt(state.remaining))
end

function M.reset()
  state.running   = false
  state.mode      = "work"
  state.remaining = WORK_SECS
  M.close_blocker()
  if state.timer then
    state.timer:stop()
    state.timer:close()
    state.timer = nil
  end
  notify("↺ Pomodoro сброшен")
end

function M.status()
  if not state.running and state.remaining == WORK_SECS then
    return "🍅 --:--"
  end
  local icon = state.mode == "work" and "🍅" or "☕"
  local pause = state.running and "" or " ⏸"
  return icon .. " " .. fmt(state.remaining) .. pause
end

function M.session_count()
  return state.session
end

return M
