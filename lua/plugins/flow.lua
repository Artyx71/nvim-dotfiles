-- ╔══════════════════════════════════════════════════════════════╗
-- ║   FLOW — навигация без трения, как у топ frontend vimmers   ║
-- ║   Источники: craftzdog, ThePrimeagen, Nick Nisi, devaslife  ║
-- ╚══════════════════════════════════════════════════════════════╝

return {

  -- ── HARPOON v2 — главный секрет потока ───────────────────────────
  -- Идея: ты всегда работаешь с 3-5 файлами в проекте.
  -- Пометь их — прыгай мгновенно, без telescope, без дерева файлов.
  -- craftzdog, ThePrimeagen — оба используют это как #1 плагин.
  --
  --   <leader>a          → добавить текущий файл в список
  --   <leader>H          → открыть меню со списком
  --   <C-1/2/3/4>        → прыгнуть на файл 1/2/3/4
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local harpoon = require("harpoon")
      return {
        { "<leader>a",  function() harpoon:list():add() end,                        desc = "Harpoon: добавить файл" },
        { "<leader>H",  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: меню" },
        { "<C-1>",      function() harpoon:list():select(1) end,                    desc = "Harpoon: файл 1" },
        { "<C-2>",      function() harpoon:list():select(2) end,                    desc = "Harpoon: файл 2" },
        { "<C-3>",      function() harpoon:list():select(3) end,                    desc = "Harpoon: файл 3" },
        { "<C-4>",      function() harpoon:list():select(4) end,                    desc = "Harpoon: файл 4" },
        { "<C-S-h>",    function() harpoon:list():prev() end,                       desc = "Harpoon: предыдущий" },
        { "<C-S-l>",    function() harpoon:list():next() end,                       desc = "Harpoon: следующий" },
      }
    end,
    config = function()
      require("harpoon"):setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })
    end,
  },

  -- ── MULTI-CURSOR — Ctrl+D как в VSCode ────────────────────────────
  -- Выдели слово → Ctrl+Down → добавляется курсор на следующее вхождение
  -- Топовые vimmers называют это "единственной вещью которой не хватало"
  --
  --   Ctrl+Down / Ctrl+Up   → добавить курсор вниз/вверх
  --   Visual → Ctrl+n        → выбрать все вхождения (как Ctrl+Shift+L)
  --   Normal → Ctrl+n        → начать multi-cursor на слове
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"]         = "<M-d>",   -- Alt+D (не конфликтует с Ctrl+D smooth scroll)
        ["Find Subword Under"] = "<M-d>",
        ["Add Cursor Down"]    = "<C-S-j>",
        ["Add Cursor Up"]      = "<C-S-k>",
        ["Select All"]         = "<C-S-l>",
      }
      vim.g.VM_theme = "iceblue"
      vim.g.VM_highlight_matches = "underline"
    end,
  },

  -- ── UNDOTREE — машина времени для кода ───────────────────────────
  -- Git не сохраняет каждое нажатие — undotree сохраняет всё.
  -- Когда "я только что сделал что-то не то но не знаю когда" — спасает.
  --
  --   <leader>u   → открыть дерево отмены
  {
    "mbbill/undotree",
    cmd  = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
    init = function()
      vim.g.undotree_WindowLayout       = 2    -- дерево справа
      vim.g.undotree_ShortIndicators    = 1
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- ── BETTER ESCAPE — выход из insert без <Esc> ─────────────────────
  -- jk или jj → мгновенный выход в Normal mode.
  -- Руки не уходят в угол клавиатуры — поток не прерывается.
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts  = {
      timeout     = 200,
      mappings    = {
        i = { j = { k = "<Esc>", j = "<Esc>" } },
        c = { j = { k = "<Esc>", j = "<Esc>" } },
        v = { j = { k = "<Esc>" } },
        s = { j = { k = "<Esc>" } },
      },
    },
  },


  -- ── PERSISTENCE — восстановление сессии ──────────────────────────
  -- Закрыл nvim → открыл → всё на месте: файлы, сплиты, позиции.
  -- Поток не начинается с нуля каждый раз.
  --
  --   <leader>qs   → восстановить последнюю сессию
  --   <leader>ql   → восстановить сессию для текущей папки
  --   <leader>qd   → не восстанавливать (разовая чистая сессия)
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts  = { dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/") },
    keys  = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Восстановить сессию" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Последняя сессия" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Не сохранять сессию" },
    },
  },
}
