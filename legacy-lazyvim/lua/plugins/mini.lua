return {

  -- ── mini.surround — быстро меняй скобки/кавычки ─────────────────
  -- cs"'  → смени " на '
  -- ds"   → удали "
  -- ys2w" → добавь " вокруг 2 слов
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add            = "ys",  -- add surround
        delete         = "ds",  -- delete surround
        find           = "gzf", -- find surround
        find_left      = "gzF",
        highlight      = "gzh",
        replace        = "cs",  -- change surround
        update_n_lines = "gzn",
      },
      n_lines = 20,
    },
  },

  -- ── mini.ai — расширенные текстобъекты ──────────────────────────
  -- di( da[ vi" va' работают лучше, поддерживают вложенность
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = {
      n_lines = 500,
      search_method = "cover_or_next",
      custom_textobjects = nil,
    },
  },

  -- ── flash.nvim — поиск + прыжок (альтернатива f/t) ──────────────
  -- s + поиск → прыгаешь на букву, видно все совпадения
  -- Очень быстро для больших прыжков в видимой области
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,      desc = "Flash remote" },
    },
    opts = {
      search = {
        mode = "fuzzy",
        exclude = {
          "notify", "cmp_menu", "noice", "flash_prompt",
          function(win)
            return not vim.api.nvim_win_get_config(win).focusable
          end,
        },
      },
      label = {
        uppercase = false,
        after = true,
        before = true,
      },
      highlight = {
        backdrop = true,
        matches = true,
        priority = 5000,
      },
    },
  },

  -- ── mini.comment — быстро комментируй ────────────────────────────
  -- gcc  → комментируй строку
  -- gc   → комментируй выделение
  -- gc   → в motion: gc2j комментируй 2 строки вниз
  {
    "nvim-mini/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = nil,
        start_of_line        = false,
        pad_comment_parts    = true,
      },
    },
  },

  -- ── treesitter-context — показывает контекст функции в топе ──────
  -- Когда скроллишь — видна функция/класс в которой ты находишься
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
    },
  },
}
