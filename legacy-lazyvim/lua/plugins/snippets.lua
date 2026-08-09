return {

  -- ── React + TypeScript snippets ───────────────────────────────────
  -- rfc, useState, useEffect, useCallback, useMemo, useRef, useContext...
  {
    "mlaursen/vim-react-snippets",
    dependencies = { "L3MON4D3/LuaSnip" },
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },

  -- ── Vue 3 snippets (Sarah Drasner — 1M+ VSCode installs) ─────────
  -- vbase-3, v-if, v-for, defineComponent, ref, computed, watch...
  {
    "sdras/vue-vscode-snippets",
    ft = { "vue" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("data") .. "/lazy/vue-vscode-snippets" },
      })
    end,
  },

  -- ── Filetype inheritance ──────────────────────────────────────────
  -- Без этого JS-сниппеты не работают в .tsx / .vue файлах
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      local ls = require("luasnip")
      ls.filetype_extend("typescript",      { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascript", "javascriptreact", "typescript" })
      ls.filetype_extend("javascriptreact", { "javascript" })
      ls.filetype_extend("vue",             { "javascript", "html", "css" })
      return opts
    end,
  },

  -- ── friendly-snippets: форс-загрузка Vue/React extras ─────────────
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
      })
    end,
  },

  -- ── Emmet ─────────────────────────────────────────────────────────
  -- div.container>ul>li*3  →  <C-z>,  → разворачивает в HTML/JSX/Vue
  -- JSX использует className вместо class автоматически
  {
    "mattn/emmet-vim",
    ft = {
      "html", "css", "scss", "less",
      "javascript", "javascriptreact",
      "typescript", "typescriptreact",
      "vue",
    },
    init = function()
      vim.g.user_emmet_mode = "i"           -- только в insert mode
      vim.g.user_emmet_leader_key = "<C-z>" -- <C-z>, для expand (C-e занят blink/harpoon)
      vim.g.user_emmet_settings = {
        javascript       = { extends = "jsx" },
        typescript       = { extends = "jsx" },
        javascriptreact  = { extends = "jsx" },
        typescriptreact  = { extends = "jsx" },
        vue              = { extends = "html" },
      }
    end,
  },
}
