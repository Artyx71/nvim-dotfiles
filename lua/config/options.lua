-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.opt.relativenumber = false

-- ── Flow / Zen options ────────────────────────────────────────────

-- Всегда держать N строк вокруг курсора — не упираться взглядом в край
vim.opt.scrolloff    = 10
vim.opt.sidescrolloff = 8

-- Плавный курсор в терминале (блок → луч → подчёркивание)
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Не мигать при поиске
vim.opt.hlsearch = true

-- Более мягкие переносы при wrap (по словам, не по символам)
vim.opt.linebreak = true
vim.opt.breakindent = true

-- Время до появления popup / hint — быстрее = живее
vim.opt.updatetime = 200

-- Не показывать лишние сообщения в командной строке
vim.opt.showmode = false  -- LazyVim уже скрывает, но явно

-- Широкий signcolumn — меньше дёрганий при появлении диагностики
vim.opt.signcolumn = "yes:1"
