return {

  -- ── Zen Mode ──────────────────────────────────────────────────────
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 0.95,
        width    = 120,   -- фиксированная ширина в символах, не процент
        height   = 1,
        options  = {
          signcolumn     = "no",
          number         = true,
          relativenumber = true,
          cursorline     = false,
          foldcolumn     = "0",
          list           = false,
        },
      },
      plugins = {
        twilight  = { enabled = true },
        gitsigns  = { enabled = false },
        tmux      = { enabled = false },
        kitty     = { enabled = false },    -- отключено — не трогать фонт
        alacritty = { enabled = false },    -- отключено — не трогать фонт
      },
    },
  },

  -- ── Twilight — dimming неактивного кода ───────────────────────────
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },
    opts = {
      dimming    = { alpha = 0.3 },
      context    = 15,
      treesitter = true,
    },
  },

  -- ── Плавный скролл через snacks (уже встроен в LazyVim) ──────────
  -- Включаем scroll + animate модули — чище чем отдельный neoscroll
  {
    "folke/snacks.nvim",
    opts = {
      -- Плавный скролл
      scroll = {
        enabled   = true,
        animate   = { duration = { step = 15, total = 200 }, easing = "outQuart" },
        spamming  = 10,
      },
      -- Анимации открытия окон, буферов, нотификаций
      animate = {
        enabled  = true,
        duration = { step = 20, total = 250 },
        easing   = "outQuart",
        fps      = 60,
      },
      -- Indent guides с анимацией
      indent = {
        enabled       = true,
        animate       = { enabled = true, style = "out", easing = "linear", duration = { step = 20, total = 200 } },
        indent        = { char = "│", hl = "SnacksIndent" },
        scope         = { enabled = true, char = "│", hl = "SnacksIndentScope" },
        chunk         = { enabled = false },
      },
      -- Дашборд
      dashboard = {
        width = 60,
        preset = {
          header = [[
  ███╗   ██╗██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██║   ██║██║████╗ ████║
  ██╔██╗ ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        sections = {
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          {
            section = "terminal",
            cmd     = "date '+   %A, %d %B  •  %H:%M'",
            height  = 2,
            padding = 1,
          },
          { section = "startup" },
        },
      },
    },
  },

  -- ── Затемнение неактивных сплитов ────────────────────────────────
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      tint       = -35,
      saturation = 0.65,
      highlight_ignore_patterns = { "WinSeparator", "Status.*", "IndentBlankline.*" },
      window_ignore_function = function(winid)
        local buf = vim.api.nvim_win_get_buf(winid)
        local ft  = vim.api.nvim_get_option_value("filetype", { buf = buf })
        local bt  = vim.api.nvim_get_option_value("buftype",  { buf = buf })
        return vim.api.nvim_win_get_config(winid).relative ~= ""
          or bt == "terminal"
          or ft == "neo-tree"
          or ft == "lazy"
          or ft == "mason"
          or ft == "noice"
      end,
    },
  },

  -- ── Подсветка слова под курсором ──────────────────────────────────
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    opts  = { delay = 120, large_file_cutoff = 2000 },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- ── Цветные скобки ────────────────────────────────────────────────
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      require("rainbow-delimiters.setup").setup({
        highlight = {
          "RainbowDelimiterRed",    "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",   "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",  "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- ── Анимированный курсор — "смазывает" при быстром движении ──────
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts  = {
      stiffness               = 0.75,
      trailing_stiffness      = 0.4,
      distance_stop_animating = 0.5,
      hide_target_hack        = true,
    },
  },

  -- ── mini.animate — анимации прыжков курсора ───────────────────────
  -- j/k при большом прыжке — плавная дуга вместо телепорта
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts  = function(_, opts)
      local animate  = require("mini.animate")
      local timing   = animate.gen_timing.linear({ duration = 80, unit = "total" })
      local path     = animate.gen_path.angle()
      return vim.tbl_deep_extend("force", opts or {}, {
        cursor  = { enable = true,  timing = timing, path = path },
        scroll  = { enable = false },  -- scroll делает snacks
        resize  = { enable = true,  timing = timing },
        open    = { enable = true,  timing = timing },
        close   = { enable = true,  timing = timing },
      })
    end,
  },
}
