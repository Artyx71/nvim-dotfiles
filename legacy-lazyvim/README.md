# 🧘 nvim-dotfiles

Personal Neovim config built on [LazyVim](https://lazyvim.github.io).
Stack: **React · Vue · TypeScript · Next.js · Nuxt · Tailwind**.
Philosophy: zero friction, zen flow, keyboard-only.

---

## Stack

| Layer | Plugin |
|---|---|
| Base | LazyVim + lazy.nvim |
| Completion | blink.cmp + LuaSnip |
| LSP | vtsls, vue-language-server, tailwindcss, cssls, html, emmet |
| Formatter | conform.nvim → prettier |
| Linter | nvim-lint → eslint_d |
| File explorer | oil.nvim (float) |
| File marks | Harpoon v2 |
| Git | gitsigns, git-conflict |
| Zen | zen-mode + twilight + smear-cursor + mini.animate |

---

## Keymaps

> `<leader>` = **Space**

### Navigation

| Key | Action |
|---|---|
| `<leader>e` | Проводник float (oil.nvim) |
| `<leader>E` | Проводник буфер (oil.nvim) |
| `-` | Открыть папку текущего файла |
| `<leader>ff` | Найти файл (Telescope) |
| `<leader>fg` | Grep по проекту |
| `<leader>fb` | Список открытых буферов |
| `<C-p>` | Command palette (Legendary) |

### Harpoon — горячие файлы

| Key | Action |
|---|---|
| `<leader>a` | Добавить файл в список |
| `<leader>H` | Открыть меню Harpoon |
| `<C-1>` | Прыжок на файл 1 |
| `<C-2>` | Прыжок на файл 2 |
| `<C-3>` | Прыжок на файл 3 |
| `<C-4>` | Прыжок на файл 4 |
| `<C-S-h>` | Предыдущий в списке |
| `<C-S-l>` | Следующий в списке |

### Zen / Flow

| Key | Action |
|---|---|
| `<leader>z` | Zen Mode (центр, без UI) |
| `<leader>tw` | Twilight — затемнить неактивный код |
| `<C-d>` / `<C-u>` | Плавный скролл |
| `jk` / `jj` | Выход из Insert mode (better-escape) |

### TypeScript / Frontend

| Key | Action |
|---|---|
| `<leader>ct` | TSC — проверка типов по всему проекту |
| `<leader>ce` | Toggle маскировки .env значений |
| `<leader>ts` | Tailwind: отсортировать классы |
| `<leader>tc` | Tailwind: toggle сворачивания классов |

### npm / package.json

| Key | Action |
|---|---|
| `<leader>ns` | Показать версии пакетов |
| `<leader>nh` | Скрыть версии |
| `<leader>nu` | Обновить пакет |
| `<leader>nd` | Удалить пакет |
| `<leader>ni` | Установить пакет |
| `<leader>np` | Сменить версию пакета |

### REST клиент (.http файлы)

| Key | Action |
|---|---|
| `<leader>rr` | Выполнить запрос |
| `<leader>rl` | Выполнить все запросы |
| `<leader>rp` | Предыдущий запрос |
| `<leader>rn` | Следующий запрос |
| `<leader>ri` | Inspect запрос |

### Git

| Key | Action |
|---|---|
| `<leader>gg` | Lazygit |
| `]x` / `[x` | Следующий / предыдущий конфликт |
| `co` | Принять текущее (ours) |
| `ct` | Принять входящее (theirs) |
| `cb` | Принять оба |

### Сессии (Persistence)

| Key | Action |
|---|---|
| `<leader>qs` | Восстановить сессию папки |
| `<leader>ql` | Последняя сессия |
| `<leader>qd` | Не сохранять сессию |

### Undotree

| Key | Action |
|---|---|
| `<leader>u` | Открыть дерево отмены |

### Автокомплит (blink.cmp)

| Key | Action |
|---|---|
| `<CR>` | Принять / развернуть сниппет |
| `<Tab>` | Следующий placeholder в сниппете |
| `<S-Tab>` | Предыдущий placeholder |
| `<C-n>` / `<C-p>` | Следующий / предыдущий элемент |
| `<C-e>` | Закрыть меню |
| `<C-y>` | Принять без закрытия |
| `<C-Space>` | Открыть принудительно |
| `<C-k>` | Показать документацию |

### Сниппеты — React

| Триггер | Результат |
|---|---|
| `rfc` | React Function Component |
| `useState` | `const [state, setState] = useState(...)` |
| `useEffect` | `useEffect(() => {}, [deps])` |
| `useCallback` | `useCallback(fn, [deps])` |
| `useMemo` | `useMemo(() => value, [deps])` |
| `useRef` | `const ref = useRef(null)` |
| `useContext` | `const ctx = useContext(Context)` |

### Сниппеты — Vue 3

| Триггер | Результат |
|---|---|
| `vbase-3-ts` | SFC с `<script setup lang="ts">` |
| `vref` | `const x = ref(value)` |
| `vcomputed` | `const x = computed(() => ...)` |
| `vwatch` | `watch(source, val => {})` |
| `vemit` | `defineEmits([...])` |
| `vprops` | `defineProps<{}>()` |
| `vonmounted` | `onMounted(() => {})` |

### Surround (mini.surround)

| Key | Action |
|---|---|
| `cs"'` | Смени " на ' |
| `ds"` | Удали " |
| `ys2w"` | Добавь " вокруг 2 слов |

### Текстобъекты (mini.ai)

| Объект | Пример |
|---|---|
| `di(` | Удали всё внутри () (вложенность работает) |
| `va[` | Выбери всё + скобки [] |
| `ci"` | Смени содержимое "" |

### Flash jump (flash.nvim)

| Key | Action |
|---|---|
| `s` | Поиск + прыжок — видно все совпадения |
| `S` | По tree-sitter нодам |
| `r` | Operator-pending (после d/c/y) |

### Comment (mini.comment)

| Key | Action |
|---|---|
| `gcc` | Комментируй строку |
| `gc2j` | Комментируй 2 строки вниз |
| `gc` | Комментируй выделение |

### Emmet (Insert mode)

| Key | Action |
|---|---|
| `<C-z>,` | Развернуть аббревиатуру |

Примеры: `div.container>ul>li*3` → `<C-z>,` → HTML/JSX.
JSX автоматически использует `className` вместо `class`.

### Multi-cursor

| Key | Action |
|---|---|
| `<M-d>` | Добавить курсор на следующее вхождение (как VSCode) |
| `<C-S-j>` | Добавить курсор вниз |
| `<C-S-k>` | Добавить курсор вверх |
| `<C-S-l>` | Выбрать все вхождения |

### Which-key

Нажми `<Space>` и подожди — всплывёт popup со всеми доступными командами.

---

## Структура

```
~/.config/nvim/
├── init.lua                          # точка входа
├── lazyvim.json                      # активные LazyVim extras
├── lua/
│   ├── config/
│   │   ├── options.lua               # vim options (scrolloff, guicursor...)
│   │   ├── keymaps.lua               # глобальные хоткеи
│   │   ├── autocmds.lua              # автокоманды
│   │   └── lazy.lua                  # инициализация lazy.nvim
│   └── plugins/
│       ├── frontend.lua              # LSP, Tailwind, Mason, prettier
│       ├── snippets.lua              # React/Vue сниппеты, Emmet
│       ├── blink-luasnip.lua         # blink.cmp → LuaSnip интеграция
│       ├── flow.lua                  # Harpoon, multi-cursor, persistence
│       ├── zen.lua                   # zen-mode, twilight, анимации
│       ├── explorer.lua              # oil.nvim
│       ├── which-key.lua             # группы хоткеев
│       └── all-themes.lua            # темы
└── lazy-lock.json                    # lock file плагинов
```

---

## Установка

```bash
git clone https://github.com/Artyx71/nvim-dotfiles ~/.config/nvim
nvim  # lazy.nvim установит все плагины автоматически
```

Нужно: `neovim >= 0.10`, `node`, `npm`, `git`, `ripgrep`, `fd`.
