# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modern Neovim configuration using Lua with lazy.nvim as the plugin manager. The configuration emphasizes modularity, with plugins organized into categories based on stability and purpose.

## Version Control

We use Jujutsu v0.35 for version control. All commands begin with `jj`.

## Key Commands

### Plugin Development

```bash
# Format Lua code
stylua lua/
```

Development plugins live in `~/Work/Tools/nvim/` and are loaded with `dev = true` in lazy.nvim specs.

### Build Commands

- **Zig**: `zig build` (configured as makeprg)
- **General build**: `<Leader>m` keybinding executes `:make`

## Architecture

### Plugin Organization

Lazy.nvim plugins are organized by type under `lua/plugins/`:

1. **completion.lua**: Completion engine (blink.cmp) and snippets
2. **editing.lua**: Text manipulation, formatting (conform.nvim), commenting, surround
3. **interface.lua**: Themes, mini.nvim modules (icons, clue, files, statusline, notify), trouble.nvim, folding (ufo)
4. **languages.lua**: Treesitter and language-specific plugins
5. **navigation.lua**: Telescope, file explorers (dirbuf), code outline (aerial)
6. **terminals.lua**: Terminal management (toggleterm) with AI agent shortcuts
7. **tools.lua**: Git (neogit, gitsigns), debugging (DAP), database (dadbod), previews, executor
8. **personal.lua**: Personal plugin development (all marked with `dev = true`)

Custom config scripts are auto-sourced from `plugin/`:

1. **lsp.lua**: LSP server list (`vim.lsp.enable()`) and `LspAttach` keymaps
2. **terminal.lua**: Terminal keymaps and `TermOpen` autocmd
3. **vecgrep.lua**: `:Vecgrep` semantic search command
4. **yank.lua**: `TextYankPost` highlight autocmd

### Plugin Loading

- Uses lazy.nvim with automatic bootstrap in init.lua
- Local development plugins loaded from `dev/` directory
- Lock file: `lazy-lock.json`

### LSP Configuration

LSP servers are configured using the native `vim.lsp.enable()` API in `plugin/lsp.lua`. Server configs live in `lsp/` directory. Key servers:

- Lua (lua_ls), Rust (rust_analyzer), TypeScript (ts_ls)
- Haskell (hls), Python (pylsp), Gleam (gleam)
- Zig (zls), Nix (nil_ls), Erlang (erlangls)
- Custom Toit server, Mojo, PureScript (purescriptls)

### Key Mappings

- **Leader**: `,` (comma)
- **Escape**: `jk` in insert mode
- **Telescope**: `<Leader>g` prefix for most searches
- **Development**: `<Leader>d` prefix for development tools
- **Build**: `<Leader>m` for make
- **Execute**: `<Leader>v` for running development code

### Active Development Projects

Personal plugins under active development (in `personal.lua` with `dev = true`):

1. **oversight-nvim**: Process oversight plugin
2. **NeoJJ**: Jujutsu integration for Neovim

Development plugins are loaded from `~/Work/Tools/nvim/` (configured in `lua/config/lazy.lua`).

# Finding Plugins

https://github.com/rockerBOO/awesome-neovim is a good place to look for new plugins.
