# darkstar

A lightweight Neovim config for fresh VPS boxes. Clone it, open nvim, and lazy.nvim installs the rest on first launch. It covers editing, fuzzy finding, treesitter highlighting, and git. LSP, completion, and debugging are out of scope; on a short-lived box you rarely miss them, and startup stays fast.

## Requirements

| Dependency | Why | Notes |
|---|---|---|
| Neovim 0.12+ | nvim-treesitter's `main` branch needs it | Build from source or grab a [release](https://github.com/neovim/neovim/releases) |
| git | Plugin installs, vim-fugitive | |
| A C compiler (`gcc` or `clang`) | Compiling treesitter parsers and the native FZF sorter | |
| `make` | Building telescope-fzf-native | |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) | Parser compilation on the treesitter `main` branch | `cargo install tree-sitter-cli` or `npm i -g tree-sitter-cli` |

Optional:

| Dependency | Why |
|---|---|
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Faster live grep in telescope; falls back to `grep` without it |
| A [Nerd Font](https://www.nerdfonts.com/) | Icons in telescope and which-key |

Debian/Ubuntu one-liner for the build tools:

```sh
apt install git build-essential ripgrep cargo && cargo install tree-sitter-cli
```

## Install

```sh
git clone <repo-url> ~/.config/nvim
nvim
```

First launch bootstraps lazy.nvim and installs every plugin. Treesitter parsers compile on demand the first time you open a file of a given type.

To try it without touching an existing config, clone to `~/.config/neovim` and run `NVIM_APPNAME=neovim nvim`.

## Plugins

- [lazy.nvim](https://github.com/folke/lazy.nvim): plugin manager
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): fuzzy finder, with the native FZF sorter when a compiler is present
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (`main` branch): syntax highlighting, parsers installed on demand
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context): sticky scope header
- [vim-fugitive](https://github.com/tpope/vim-fugitive): git
- [vim-surround](https://github.com/tpope/vim-surround): surround text objects
- [undotree](https://github.com/mbbill/undotree): undo history
- [which-key.nvim](https://github.com/folke/which-key.nvim): keymap hints
- [fidget.nvim](https://github.com/j-hui/fidget.nvim): progress notifications
- [dracula.nvim](https://github.com/Mofiqul/dracula.nvim): colorscheme, transparent background by default

Comment toggling uses the built-in `gc` operator.

## Key bindings

Leader is space. Press `<leader>?` for buffer-local bindings, or start typing and which-key shows the rest. Highlights:

| Keys | Action |
|---|---|
| `<leader>pv` | File explorer (netrw) |
| `<leader>ff` / `<leader>fg` | Find files / live grep |
| `<leader>fb` / `<leader>fr` | Buffers / recent files |
| `<leader>gs` | Git status |
| `<leader>u` | Undo tree |
| `<leader>y` / `<leader>d` | Yank to system clipboard / delete without yanking |
| `<leader>pcp` / `<leader>pcd` | Dracula with transparent / opaque background |

## Structure

```text
init.lua                  entry point, sets the leader key
lua/darkstar/
  init.lua                autocmds, netrw, shada
  set.lua                 options
  remap.lua               keymaps
  lazy.lua                lazy.nvim bootstrap
  plugins/                one file per plugin spec
```
