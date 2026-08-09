# nvim-dotfiles

Personal Neovim configurations for frontend development.

## Configurations

| Directory | Status | Description |
| --- | --- | --- |
| [`kickstart/`](./kickstart/) | Current | Lightweight config based on Kickstart and Neovim 0.12 `vim.pack` |
| [`legacy-lazyvim/`](./legacy-lazyvim/) | Archived | Previous full LazyVim configuration kept for reference |

The current config targets JavaScript, TypeScript, React, Next.js, Vue and
Nuxt. It includes vtsls, vue_ls, ESLint, Tailwind CSS, Emmet, Prettier,
Treesitter, Oil, Harpoon, Undotree, project sessions, Focus Mode and seamless
tmux navigation.

## Install

```sh
git clone https://github.com/Artyx71/nvim-dotfiles.git ~/.config/nvim-dotfiles
ln -s ~/.config/nvim-dotfiles/kickstart ~/.config/nvim
nvim
```

Neovim installs plugins through `vim.pack`; Mason installs the configured
language servers and formatters.

## Main keymaps

`<leader>` is `Space`.

| Key | Action |
| --- | --- |
| `<leader>e` | Open Oil in a floating window |
| `-` | Open the parent directory in Oil |
| `<leader>a` | Add the current file to Harpoon |
| `<leader>H` | Open the Harpoon menu |
| `<leader>1..4` | Jump to a Harpoon file |
| `<leader>u` | Toggle Undotree |
| `<leader>z` | Toggle distraction-free Focus Mode |
| `<leader>j` | Jump to any visible word |
| `[i` / `]i` | Jump to the top / bottom of the current indent scope |
| `<leader>tc` | Toggle Treesitter context at the top of the window |
| `<leader>pr` | Restore the current project's session |
| `<leader>pl` | Restore the last session |
| `<leader>ps` | Select a saved project session |
| `<leader>pd` | Disable session saving for the current launch |
| `<leader>f` | Format the current buffer |
| `<C-h/j/k/l>` | Move across Neovim windows and tmux panes |

Focus Mode zooms the current buffer to the full editor, hides status/tab lines,
signs and inline diagnostic noise, and temporarily disables LSP inlay hints.
Toggle it again with `<leader>z` (or run `:Focus`) to restore the exact previous
state.

The tmux side of seamless navigation lives in `~/.config/tmux/tmux.conf` and
is intentionally not stored in this Neovim-only repository.
