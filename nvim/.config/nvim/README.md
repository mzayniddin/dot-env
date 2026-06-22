# Neovim Configuration

A [lazy.nvim](https://github.com/folke/lazy.nvim)-based Neovim setup (kickstart-style) with
LSP via [mason](https://github.com/mason-org/mason.nvim), treesitter, completion (nvim-cmp +
LuaSnip), telescope, and shader support (GLSL / HLSL / WGSL).

## Prerequisites

Install these **before** launching Neovim for the first time. Most plugins/tools are installed
automatically by lazy.nvim and Mason, but they rely on the system tools below being present.

### Required

| Tool | Why it's needed |
| --- | --- |
| **Neovim ≥ 0.10** (0.11+ recommended; tested on 0.12.1) | The editor itself |
| **git** | lazy.nvim clones plugins |
| **C compiler** (`cc` / `clang` / `gcc`) | Compiling treesitter parsers, telescope-fzf-native |
| **tree-sitter CLI** | ⚠️ **Required** by nvim-treesitter's `main` branch to build parsers. Without it `:TSInstall`/`:TSUpdate` fail with `ENOENT: 'tree-sitter'`. |
| **make** | Builds `telescope-fzf-native` and LuaSnip's regex support |
| **ripgrep** (`rg`) | Telescope live-grep |
| **fd** (`fd`) | Telescope file finding |
| **A Nerd Font** | Icons in the statusline/UI. The config sets `vim.g.have_nerd_font = true`; without a Nerd Font in your terminal, icons render as boxes. |
| **unzip / curl / tar** | Mason downloads LSP servers & formatters |

### Language runtimes (install only what you use)

Mason auto-installs the language servers and formatters, but several of them need a runtime present:

| Runtime | Powers |
| --- | --- |
| **Node.js + npm** | `ts_ls`, `eslint`, `tailwindcss`, `astro`, `prettier`, supermaven |
| **Python 3** | `pyright` |
| **Go** | `gopls` |

### Installed automatically by Mason (first launch, needs network)

- **LSP servers:** `pyright`, `ts_ls`, `astro`, `tailwindcss`, `eslint`, `gopls`, `lua_ls`,
  `glsl_analyzer`, `wgsl_analyzer`
- **Formatters / linters:** `stylua`, `prettier`, `clang-format`

## Setup

### 1. Install prerequisites

**macOS (Homebrew):**

```sh
brew install neovim git ripgrep fd make tree-sitter-cli
# Xcode Command Line Tools provide the C compiler:
xcode-select --install
# A Nerd Font, e.g.:
brew install --cask font-jetbrains-mono-nerd-font
# Language runtimes you use:
brew install node python go
```

> Note: the Homebrew `tree-sitter` formula is **library-only**. The CLI you need is the
> separate `tree-sitter-cli` formula.

**Linux (Debian/Ubuntu):**

```sh
sudo apt install neovim git ripgrep fd-find build-essential
# tree-sitter CLI (via cargo or npm):
cargo install tree-sitter-cli   # or: npm install -g tree-sitter-cli
# Node / Python / Go as needed, plus a Nerd Font of your choice.
```

### 2. Install the config

This lives in a dotfiles repo and is expected at `~/.config/nvim`. If you use GNU stow from the
`dot-env` repo root:

```sh
stow nvim
```

Otherwise symlink/copy this directory to `~/.config/nvim`.

### 3. First launch

```sh
nvim
```

On first start, lazy.nvim bootstraps and installs plugins, and Mason installs the LSP servers and
formatters. Treesitter parsers compile via the `tree-sitter` CLI + C compiler.

### 4. Verify

Inside Neovim:

- `:Lazy` — plugins installed/updated
- `:Mason` — LSP servers & formatters installed
- `:checkhealth` — flags any missing prerequisites
- `:TSUpdate` — (re)build/update all treesitter parsers

## Shader support (GLSL / HLSL / WGSL)

| Language | Filetype | Highlighting | LSP | Formatting |
| --- | --- | --- | --- | --- |
| **GLSL** (`.vert .frag .comp .geom .glsl` …) | built-in | `glsl` parser | `glsl_analyzer` | `clang-format` |
| **WGSL** (`.wgsl`) | built-in | `wgsl` parser | `wgsl_analyzer` | via LSP |
| **HLSL** (`.hlsl .hlsli .fx .fxh .cginc .compute`) | custom (see `lua/core/vim-options.lua`) | `hlsl` parser | — (no reliable server) | `clang-format` |

HLSL extension detection is registered in `lua/core/vim-options.lua` via `vim.filetype.add`.
`clang-format` picks up a project-local `.clang-format` file if present.

## Notes & troubleshooting

- **`:TSUpdate` fails with `ENOENT: 'tree-sitter'`** → the `tree-sitter` CLI isn't on your `PATH`.
  Install it (`brew install tree-sitter-cli`) and retry. This config uses nvim-treesitter's
  `main` branch, which compiles parsers with the CLI (unlike the legacy `master` branch).
- **Stale parser build errors** (`ENOTEMPTY` / `EEXIST`) → clear the temp dirs and retry:
  `rm -rf ~/.cache/nvim/tree-sitter-*-tmp`, then `:TSUpdate`.
- Parsers are installed to `~/.local/share/nvim/site/parser/`.
