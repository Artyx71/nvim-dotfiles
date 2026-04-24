return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {},
    },
    config = function(_, opts)
      local wk = require("which-key")

      -- Языки: ru, en
      local current_lang = "ru"

      local specs = {
        ru = {
          { "<leader>H",  group = "Harpoon",                icon = "󱡅" },
          { "<leader>a",  desc  = "Добавить файл",         icon = "󱡅" },
          { "<leader>z",  desc  = "Дзен режим",             icon = "🧘" },
          { "<leader>tw", desc  = "Twilight (затемнение)",  icon = "" },
          { "<leader>u",  desc  = "Дерево отмены",          icon = "" },
          { "<leader>e",  desc  = "Проводник (float)",      icon = "" },
          { "<leader>E",  desc  = "Проводник (буфер)",      icon = "" },
          { "<leader>ce", desc  = "Маскировка .env",        icon = "" },
          { "<leader>ct", desc  = "Проверка типов (TSC)",   icon = "󰛦" },
          { "<leader>tc", desc  = "Tailwind (скрыть)",       icon = "" },
          { "<leader>ts", desc  = "Tailwind (сортировать)", icon = "" },
          { "<leader>n",  group = "npm / package.json",     icon = "" },
          { "<leader>r",  group = "REST клиент",            icon = "󰖟" },
          { "<C-1>",      desc  = "Файл 1",                 icon = "󱡅" },
          { "<C-2>",      desc  = "Файл 2",                 icon = "󱡅" },
          { "<C-3>",      desc  = "Файл 3",                 icon = "󱡅" },
          { "<C-4>",      desc  = "Файл 4",                 icon = "󱡅" },
        },
        en = {
          { "<leader>H",  group = "Harpoon",                icon = "󱡅" },
          { "<leader>a",  desc  = "Add file",               icon = "󱡅" },
          { "<leader>z",  desc  = "Zen mode",               icon = "🧘" },
          { "<leader>tw", desc  = "Twilight toggle",        icon = "" },
          { "<leader>u",  desc  = "Undotree",               icon = "" },
          { "<leader>e",  desc  = "File browser (float)",   icon = "" },
          { "<leader>E",  desc  = "File browser (buffer)",  icon = "" },
          { "<leader>ce", desc  = ".env cloak toggle",      icon = "" },
          { "<leader>ct", desc  = "TypeScript check",       icon = "󰛦" },
          { "<leader>tc", desc  = "Tailwind conceal",       icon = "" },
          { "<leader>ts", desc  = "Tailwind sort",          icon = "" },
          { "<leader>n",  group = "npm / package.json",     icon = "" },
          { "<leader>r",  group = "REST client",            icon = "󰖟" },
          { "<C-1>",      desc  = "File 1",                 icon = "󱡅" },
          { "<C-2>",      desc  = "File 2",                 icon = "󱡅" },
          { "<C-3>",      desc  = "File 3",                 icon = "󱡅" },
          { "<C-4>",      desc  = "File 4",                 icon = "󱡅" },
        },
      }

      local function set_lang(lang)
        if specs[lang] then
          current_lang = lang
          opts.spec = specs[lang]
          wk.setup(opts)
          vim.notify("Language: " .. lang:upper(), vim.log.levels.INFO)
        end
      end

      -- Инициальная загрузка
      opts.spec = specs[current_lang]
      wk.setup(opts)

      -- Команда переключения
      vim.api.nvim_create_user_command("WhichKeyLang", function(args)
        if args.args == "ru" or args.args == "en" then
          set_lang(args.args)
        else
          vim.notify("Use :WhichKeyLang ru or :WhichKeyLang en", vim.log.levels.WARN)
        end
      end, { nargs = 1, complete = function() return { "ru", "en" } end })

      -- Хоткей для быстрого переключения: <leader>tl
      vim.keymap.set("n", "<leader>tl", function()
        local next_lang = current_lang == "ru" and "en" or "ru"
        set_lang(next_lang)
      end, { noremap = true, desc = "Toggle language (Ru/En)" })
    end,
  },
}
