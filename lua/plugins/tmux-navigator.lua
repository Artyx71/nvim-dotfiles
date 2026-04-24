return {
  -- ── vim-tmux-navigator — seamless navigation between nvim and tmux ─────
  -- Ctrl+h/j/k/l работает одинаково в nvim и tmux
  -- Перемещайся между окнами neovim и tmux панелями одной командой
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",     desc = "Navigate left (nvim/tmux)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>",     desc = "Navigate down (nvim/tmux)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>",       desc = "Navigate up (nvim/tmux)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>",    desc = "Navigate right (nvim/tmux)" },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate previous (nvim/tmux)" },
    },
  },
}
