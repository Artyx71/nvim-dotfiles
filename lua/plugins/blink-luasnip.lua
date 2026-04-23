return {
  -- Переключаем blink.cmp на LuaSnip.
  -- По умолчанию LazyVim использует preset="default" (vim.snippet),
  -- который не видит LuaSnip-нативные сниппеты (vim-react-snippets).
  -- С preset="luasnip" blink показывает ВСЕ сниппеты из LuaSnip в меню.
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      snippets = {
        preset = "luasnip",
      },
      keymap = {
        preset = "enter",
        -- Enter  → принять сниппет / автокомплит
        -- Tab    → следующий placeholder внутри сниппета
        -- S-Tab  → предыдущий placeholder
        -- C-e    → закрыть меню (blink default, теперь свободен)
        ["<Tab>"]   = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-y>"]   = { "select_and_accept" },
      },
    },
  },

  -- LuaSnip должен быть загружен до blink
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "echo 'NOTE: jsregexp not built' && make install_jsregexp"
    end)(),
  },
}
