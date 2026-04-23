-- ╔══════════════════════════════════════════════════════════════╗
-- ║              FRONTEND DEVELOPMENT PLUGINS                   ║
-- ║   React · Vue · TypeScript · Next.js · Nuxt · Tailwind      ║
-- ╚══════════════════════════════════════════════════════════════╝

return {

  -- ── LazyVim Extras ───────────────────────────────────────────────

  -- TypeScript/TSX: vtsls LSP, treesitter, nvim-ts-autotag
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Vue 3/2: vue-language-server (volar) + TypeScript plugin
  { import = "lazyvim.plugins.extras.lang.vue" },

  -- Tailwind CSS: LSP autocomplete + class sorting
  { import = "lazyvim.plugins.extras.lang.tailwind" },

  -- JSON: jsonls + schemastore (tsconfig, package.json schemas)
  { import = "lazyvim.plugins.extras.lang.json" },

  -- ── TypeScript DX ────────────────────────────────────────────────

  -- Async project-wide TypeScript type checking (:TSC command)
  -- Shows all type errors across the whole project, not just open files
  {
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    keys = {
      { "<leader>ct", "<cmd>TSC<cr>", desc = "TypeScript Check (project-wide)" },
    },
    opts = {
      auto_open_qflist = true,
      spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
    },
  },

  -- Translates cryptic TypeScript errors into plain English
  -- e.g. "Type 'X' is not assignable to type 'Y'" → human explanation
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = { auto_override_publish_diagnostics = true },
  },

  -- ── HTML / JSX / Vue Tags ────────────────────────────────────────

  -- Auto-close and auto-rename HTML/JSX/TSX/Vue tags via treesitter
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- ── Tailwind ─────────────────────────────────────────────────────

  -- Better Tailwind integration: color previews, class folding, sorting
  -- Shows actual color swatches next to Tailwind classes in the gutter
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    ft = {
      "html", "css", "scss",
      "javascript", "javascriptreact",
      "typescript", "typescriptreact",
      "vue", "svelte",
    },
    opts = {
      document_color = {
        enabled = true,
        kind = "inline",    -- "foreground" | "background" | "inline"
        inline_symbol = "󰝤 ",
        debounce = 200,
      },
      conceal = {
        enabled = false,    -- set true to fold long class strings
        min_length = 60,
      },
    },
    keys = {
      { "<leader>tc", "<cmd>TailwindConcealToggle<cr>", desc = "Tailwind Conceal Toggle" },
      { "<leader>ts", "<cmd>TailwindSort<cr>", desc = "Tailwind Sort Classes" },
    },
  },

  -- ── package.json ─────────────────────────────────────────────────

  -- Shows npm package versions inline in package.json
  -- Highlights outdated packages, lets you update/install from nvim
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    event = "BufRead package.json",
    opts = { colors = { up_to_date = "#3C4048", outdated = "#d19a66" } },
    keys = {
      { "<leader>ns", function() require("package-info").show() end,    desc = "Show package versions" },
      { "<leader>nh", function() require("package-info").hide() end,    desc = "Hide package versions" },
      { "<leader>nu", function() require("package-info").update() end,  desc = "Update package" },
      { "<leader>nd", function() require("package-info").delete() end,  desc = "Delete package" },
      { "<leader>ni", function() require("package-info").install() end, desc = "Install package" },
      { "<leader>np", function() require("package-info").change_version() end, desc = "Change package version" },
    },
  },

  -- ── Color Preview ─────────────────────────────────────────────────

  -- Inline color swatches for hex, rgb, hsl, CSS variables, Tailwind
  -- Works across CSS, SCSS, JS, TS, Vue, HTML files
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
      render = "background",      -- "foreground" | "background" | "virtual"
      enable_named_colors = true,
      enable_tailwind = true,
    },
  },

  -- ── .env Protection ───────────────────────────────────────────────

  -- Masks secret values in .env files (shows KEY=******* instead of value)
  -- Prevents accidental leaks when screen sharing or recording
  {
    "laytan/cloak.nvim",
    event = "BufRead .env*",
    opts = {
      enabled = true,
      cloak_character = "*",
      highlight_group = "Comment",
      patterns = {
        { file_pattern = ".env*", cloak_pattern = "=.+" },
        { file_pattern = "*.env", cloak_pattern = "=.+" },
      },
    },
    keys = {
      { "<leader>ce", "<cmd>CloakToggle<cr>", desc = "Toggle .env cloaking" },
    },
  },

  -- ── Git Conflicts ─────────────────────────────────────────────────

  -- (My idea) Beautiful UI for git merge conflicts
  -- Navigate between conflicts with ]x / [x, choose ours/theirs/both
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPre",
    version = "*",
    opts = {
      default_mappings = true,     -- ]x [x co ct cb
      disable_diagnostics = true,  -- hides LSP errors inside conflict blocks
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
  },

  -- ── HTTP Client ───────────────────────────────────────────────────

  -- (My idea) REST client inside nvim — test API endpoints without leaving editor
  -- Write .http/.rest files with requests, run with <leader>rr
  -- No luarocks/lua5.1 dependency (unlike rest-nvim v3)
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    keys = {
      { "<leader>rr", function() require("kulala").run() end,          desc = "Run REST request" },
      { "<leader>rl", function() require("kulala").run_all() end,      desc = "Run all REST requests" },
      { "<leader>rp", function() require("kulala").jump_prev() end,    desc = "Prev REST request" },
      { "<leader>rn", function() require("kulala").jump_next() end,    desc = "Next REST request" },
      { "<leader>ri", function() require("kulala").inspect() end,      desc = "Inspect REST request" },
    },
    opts = {
      default_view = "body",
      default_env = "dev",
      debug = false,
    },
  },

  -- ── LSP: CSS, HTML, Emmet ─────────────────────────────────────────

  -- Add CSS, HTML, Emmet language servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},       -- CSS / SCSS / LESS
        html = {},        -- HTML
        emmet_ls = {      -- Emmet expansions: div.container>ul>li*3<Tab>
          filetypes = {
            "html", "css", "scss",
            "javascript", "javascriptreact",
            "typescript", "typescriptreact",
            "vue",
          },
          init_options = {
            html = { options = { ["bem.enabled"] = true } },
          },
        },
        stylelint_lsp = { -- CSS/SCSS linting
          filetypes = { "css", "scss", "less", "vue" },
        },
      },
    },
  },

  -- ── Mason Tools ───────────────────────────────────────────────────

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Formatters
        "prettier",
        "eslint_d",
        -- LSP servers
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "stylelint-lsp",
      },
    },
  },

  -- ── Formatters ────────────────────────────────────────────────────

  -- Use prettier for all frontend file types
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        vue             = { "prettier" },
        css             = { "prettier" },
        scss            = { "prettier" },
        less            = { "prettier" },
        html            = { "prettier" },
        json            = { "prettier" },
        jsonc           = { "prettier" },
        yaml            = { "prettier" },
        markdown        = { "prettier" },
        graphql         = { "prettier" },
      },
    },
  },

  -- ── Treesitter Parsers ────────────────────────────────────────────

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "html", "css", "scss",
        "javascript", "typescript", "tsx",
        "vue", "svelte",
        "json", "jsonc",
        "graphql",
        "yaml",
        "http", "regex",
      })
    end,
  },
}
