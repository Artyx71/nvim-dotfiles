return {

  -- ── oil.nvim — файловый менеджер как буфер, floating ─────────────
  -- Работает в Zen Mode: открывается поверх как float, не ломает layout.
  -- Редактируешь файлы как текст: удалил строку = удалил файл,
  -- переименовал строку = переименовал файл. Сохраняешь :w — применяется.
  --
  --   <leader>e   → открыть float-проводник в текущей папке
  --   <leader>E   → открыть в левой панели (классический сайдбар)
  --   q / <Esc>   → закрыть
  --   <CR>        → войти в папку / открыть файл
  --   -           → подняться на уровень выше (из любого буфера тоже)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "<leader>e",
        function() require("oil").toggle_float() end,
        desc = "Проводник (float)",
      },
      {
        "<leader>E",
        function() require("oil").open() end,
        desc = "Проводник (буфер)",
      },
      {
        "-",
        function() require("oil").open() end,
        desc = "Открыть папку текущего файла",
      },
    },
    opts = {
      default_file_explorer = false, -- neo-tree остаётся для <leader>fe
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,

      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },

      keymaps = {
        ["g?"]     = "actions.show_help",
        ["<CR>"]   = "actions.select",
        ["<C-v>"]  = { "actions.select", opts = { vertical = true } },
        ["<C-x>"]  = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"]  = { "actions.select", opts = { tab = true } },
        ["<C-p>"]  = "actions.preview",
        ["<C-r>"]  = "actions.refresh",
        ["-"]      = "actions.parent",
        ["_"]      = "actions.open_cwd",
        ["`"]      = "actions.cd",
        ["~"]      = { "actions.cd", opts = { scope = "tab" } },
        ["gs"]     = "actions.change_sort",
        ["gx"]     = "actions.open_external",
        ["g."]     = "actions.toggle_hidden",
        ["q"]      = "actions.close",
        ["<Esc>"]  = "actions.close",
      },

      use_default_keymaps = false,

      -- Показывать скрытые файлы (.env, .gitignore и т.д.)
      view_options = {
        show_hidden = true,
        natural_order = true,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },

      -- Float настройки — красиво и по центру
      float = {
        padding       = 2,
        max_width     = 80,
        max_height    = 30,
        border        = "rounded",
        win_options   = { winblend = 0 },
      },

      -- Подтверждение перед опасными операциями
      confirmation = {
        max_unopened = 10,
      },
    },
  },

  -- neo-tree остаётся, но уходит с <leader>e на <leader>fe
  -- (LazyVim уже добавил его через extras, просто меняем кейбинд)
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        false, -- убираем дефолтный <leader>e у neo-tree
      },
      {
        "<leader>fe",
        false,
      },
      {
        "<leader>fE",
        false,
      },
      {
        "<leader>ge",
        false,
      },
      {
        "<leader>be",
        false,
      },
    },
  },
}
