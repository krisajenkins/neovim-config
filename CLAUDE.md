# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modern Neovim configuration using Lua with lazy.nvim as the plugin manager. The configuration emphasizes modularity, with plugins organized into categories based on stability and purpose.

## Version Control

We use Jujutsu v0.35 for version control. All commands begin with `jj`.

## Key Commands

### Plugin Development

For plugins in the `dev/` directory (telescope-kafka.nvim, telescope-docker.nvim, telescope-quix.nvim):

```bash
# Run tests for a specific plugin
cd dev/telescope-kafka.nvim && make test
cd dev/telescope-docker.nvim && make test
cd dev/telescope-quix.nvim && make test

# Format Lua code
stylua lua/
```

### Build Commands

- **Zig**: `zig build` (configured as makeprg)
- **General build**: `<Leader>m` keybinding executes `:make`

## Architecture

### Plugin Organization

Plugins are organized by type under `lua/plugins/`:

1. **lsp-completion.lua**: LSP servers, completion, and snippets
2. **navigation.lua**: Telescope, file explorers, search tools
3. **editing.lua**: Text manipulation, formatting, commenting
4. **interface.lua**: Themes, UI components, statusline, folding
5. **tools.lua**: Git, debugging, terminals, development tools
6. **languages.lua**: Language-specific support and treesitter
7. **ai.lua**: AI/LLM integrations (Claude, Ollama)
8. **experimental.lua**: Plugins being evaluated
9. **personal.lua**: Personal plugin development (all marked with `dev = true`)

### Plugin Loading

- Uses lazy.nvim with automatic bootstrap in init.lua
- Local development plugins loaded from `dev/` directory
- Lock file: `lazy-lock.json`

### LSP Configuration

Configured servers are defined in `graduated.lua` with `lspconfig`. Key servers:

- Lua (lua_ls), Rust (rust_analyzer), TypeScript (ts_ls)
- Haskell (hls), Python (pyright), Gleam (gleam)
- Custom Toit server at `~/src/sdk/toit/build/toitlsp`

### Key Mappings

- **Leader**: `,` (comma)
- **Escape**: `jk` in insert mode
- **Telescope**: `<Leader>g` prefix for most searches
- **Development**: `<Leader>d` prefix for development tools
- **Build**: `<Leader>m` for make
- **Execute**: `<Leader>v` for running development code

### Active Development Projects

Three Telescope extensions are under active development:

1. **telescope-kafka.nvim**: Kafka topic/consumer group browsing
2. **telescope-docker.nvim**: Docker container/image management
3. **telescope-quix.nvim**: Quix platform integration

Each uses:

- mini.test for testing
- Makefile for test automation
- Standard Telescope extension structure
