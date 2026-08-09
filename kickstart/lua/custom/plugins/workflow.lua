local function gh(repo) return 'https://github.com/' .. repo end

-- Keep plugin-provided mappings explicit so they remain easy to discover and
-- change while learning Neovim.
vim.g.tmux_navigator_no_mappings = 1

vim.pack.add({
  gh 'stevearc/oil.nvim',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
  gh 'mbbill/undotree',
  gh 'christoomey/vim-tmux-navigator',
}, { load = true })

require('oil').setup {
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    natural_order = true,
  },
  float = {
    border = 'rounded',
    max_width = 90,
    max_height = 32,
    padding = 2,
  },
}

vim.keymap.set('n', '<leader>e', '<cmd>Oil --float<CR>', { desc = '[E]xplorer' })
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })

local harpoon = require 'harpoon'
harpoon:setup {
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  },
}

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'H[a]rpoon add file' })
vim.keymap.set('n', '<leader>H', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon menu' })
for index = 1, 4 do
  local harpoon_index = index
  vim.keymap.set('n', '<leader>' .. harpoon_index, function() harpoon:list():select(harpoon_index) end, { desc = 'Harpoon file ' .. harpoon_index })
end

vim.g.undotree_WindowLayout = 2
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_SetFocusWhenToggle = 1
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = '[U]ndo tree' })

local tmux_directions = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}
for key, direction in pairs(tmux_directions) do
  vim.keymap.set({ 'n', 't' }, '<C-' .. key .. '>', '<cmd>TmuxNavigate' .. direction .. '<CR>', { desc = 'Navigate ' .. direction:lower() })
end
vim.keymap.set({ 'n', 't' }, '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>', { desc = 'Navigate to previous pane' })
