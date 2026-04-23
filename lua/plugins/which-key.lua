return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>H",  group = "harpoon",              icon = "󱡅" },
        { "<leader>a",  desc  = "Harpoon: добавить",    icon = "󱡅" },
        { "<leader>z",  desc  = "Zen Mode",              icon = "🧘" },
        { "<leader>tw", desc  = "Twilight toggle",       icon = "" },
        { "<leader>u",  desc  = "Undotree",              icon = "" },
        { "<leader>e",  desc  = "Проводник (float)",     icon = "" },
        { "<leader>E",  desc  = "Проводник (буфер)",     icon = "" },
        { "<leader>ce", desc  = ".env cloak toggle",     icon = "" },
        { "<leader>ct", desc  = "TypeScript check",      icon = "󰛦" },
        { "<leader>tc", desc  = "Tailwind conceal",      icon = "" },
        { "<leader>ts", desc  = "Tailwind sort",         icon = "" },
        { "<leader>n",  group = "npm / package.json",    icon = "" },
        { "<leader>r",  group = "REST client",           icon = "󰖟" },
        { "<C-h>",      desc  = "Harpoon: файл 1",       icon = "󱡅" },
        { "<C-t>",      desc  = "Harpoon: файл 2",       icon = "󱡅" },
        { "<C-n>",      desc  = "Harpoon: файл 3",       icon = "󱡅" },
        { "<C-s>",      desc  = "Harpoon: файл 4",       icon = "󱡅" },
      },
    },
  },
}
