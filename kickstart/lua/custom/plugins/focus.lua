local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add({
  gh 'folke/persistence.nvim',
  gh 'nvim-treesitter/nvim-treesitter-context',
}, { load = true })

-- A fast visible-screen jump without opening a picker or typing a search.
local jump2d = require 'mini.jump2d'
jump2d.setup {
  mappings = { start_jumping = '' },
  view = {
    dim = true,
    n_steps_ahead = 1,
  },
  allowed_windows = {
    current = true,
    not_current = false,
  },
}

vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j', function()
  jump2d.start(jump2d.builtin_opts.word_start)
end, { desc = '[J]ump anywhere visible' })

-- Show only the scope around the cursor. The text objects are disabled because
-- `ii` and `ai` already belong to mini.ai in this config.
local indentscope = require 'mini.indentscope'
indentscope.setup {
  draw = { animation = indentscope.gen_animation.none() },
  mappings = {
    object_scope = '',
    object_scope_with_border = '',
    goto_top = '[i',
    goto_bottom = ']i',
  },
  options = { try_as_border = true },
  symbol = '│',
}

local indentscope_excluded = {
  [''] = false,
  checkhealth = true,
  help = true,
  lazy = true,
  mason = true,
  oil = true,
  qf = true,
  terminal = true,
  text = true,
  Trouble = true,
  TelescopePrompt = true,
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  group = vim.api.nvim_create_augroup('kickstart-indentscope', { clear = true }),
  callback = function(event)
    local buffer = event.buf
    vim.b[buffer].miniindentscope_disable = vim.bo[buffer].buftype ~= '' or indentscope_excluded[vim.bo[buffer].filetype] == true
  end,
})

-- Keep a small amount of syntax context visible when a long component or
-- callback scrolls off screen.
local treesitter_context = require 'treesitter-context'
treesitter_context.setup {
  enable = true,
  max_lines = 3,
  multiline_threshold = 2,
  mode = 'cursor',
  separator = '─',
}

vim.keymap.set('n', '<leader>tc', function() treesitter_context.toggle() end, { desc = '[T]oggle syntax [C]ontext' })

-- Sessions are project-oriented: restore the current working directory, the
-- most recent project, or choose one explicitly.
local persistence = require 'persistence'
persistence.setup {
  dir = vim.fn.stdpath 'state' .. '/sessions/',
  need = 1,
  branch = true,
}

vim.keymap.set('n', '<leader>pr', function() persistence.load() end, { desc = '[P]roject [R]estore session' })
vim.keymap.set('n', '<leader>pl', function() persistence.load { last = true } end, { desc = '[P]roject restore [L]ast session' })
vim.keymap.set('n', '<leader>ps', function() persistence.select() end, { desc = '[P]roject [S]elect session' })
vim.keymap.set('n', '<leader>pd', function() persistence.stop() end, { desc = '[P]roject [D]isable session save' })

require('which-key').add {
  { '<leader>p', group = '[P]roject session' },
}

-- Focus Mode combines mini.misc's temporary zoom with quieter diagnostics and
-- UI. Every changed setting is restored when the mode is toggled off.
local mini_misc = require 'mini.misc'
local focus_state

local function set_inlay_hints(buffer, enabled)
  if not vim.lsp.inlay_hint or not vim.api.nvim_buf_is_valid(buffer) then return end
  pcall(vim.lsp.inlay_hint.enable, enabled, { bufnr = buffer })
end

local function focus_disable()
  if not focus_state then return end

  local state = focus_state
  focus_state = nil

  if state.close_autocmd then pcall(vim.api.nvim_del_autocmd, state.close_autocmd) end
  if not state.window_was_closed and vim.api.nvim_win_is_valid(state.focus_window) then mini_misc.zoom() end

  vim.o.laststatus = state.laststatus
  vim.o.showtabline = state.showtabline
  vim.diagnostic.config(state.diagnostics)
  set_inlay_hints(state.buffer, state.inlay_hints)

  vim.notify 'Focus mode disabled'
end

local function focus_enable()
  local buffer = vim.api.nvim_get_current_buf()
  local diagnostics = vim.deepcopy(vim.diagnostic.config())
  local inlay_hints = false
  if vim.lsp.inlay_hint then
    local ok, enabled = pcall(vim.lsp.inlay_hint.is_enabled, { bufnr = buffer })
    inlay_hints = ok and enabled or false
  end

  -- If another plain mini.misc zoom is open, close it before entering focus.
  if not mini_misc.zoom(buffer) then mini_misc.zoom(buffer) end

  local focus_window = vim.api.nvim_get_current_win()
  focus_state = {
    buffer = buffer,
    diagnostics = diagnostics,
    focus_window = focus_window,
    inlay_hints = inlay_hints,
    laststatus = vim.o.laststatus,
    showtabline = vim.o.showtabline,
    window_was_closed = false,
  }

  vim.o.laststatus = 0
  vim.o.showtabline = 0
  vim.wo[focus_window].signcolumn = 'no'
  vim.wo[focus_window].foldcolumn = '0'
  vim.wo[focus_window].colorcolumn = ''
  vim.wo[focus_window].list = false

  vim.diagnostic.config {
    virtual_text = false,
    virtual_lines = false,
    signs = false,
    underline = true,
  }
  set_inlay_hints(buffer, false)

  focus_state.close_autocmd = vim.api.nvim_create_autocmd('WinClosed', {
    pattern = tostring(focus_window),
    once = true,
    callback = function()
      if not focus_state then return end
      focus_state.window_was_closed = true
      vim.schedule(focus_disable)
    end,
  })

  vim.notify 'Focus mode enabled'
end

local function focus_toggle()
  if focus_state then
    focus_disable()
  else
    focus_enable()
  end
end

vim.api.nvim_create_user_command('Focus', focus_toggle, { desc = 'Toggle distraction-free focus mode' })
vim.keymap.set('n', '<leader>z', focus_toggle, { desc = 'Toggle focus mode' })
