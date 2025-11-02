# Neovim Plugin Organization Review

Date: 2026-01-25

## Current Structure

```
lua/plugins/
├── completion.lua   # blink.cmp (81 lines)
├── editing.lua      # formatting, surround, comments (117 lines)
├── interface.lua    # mini.nvim, trouble, ufo (170 lines)
├── languages.lua    # treesitter, language-specific (82 lines)
├── navigation.lua   # telescope, aerial, dirbuf (124 lines)
├── personal.lua     # your dev plugins (155 lines, ~60% commented)
├── terminals.lua    # toggleterm only (92 lines)
└── tools.lua        # git, dap, dadbod, previews (176 lines)
```

## Strengths

### 1. Functional Grouping

Categories are intuitive and discoverable. Someone new to the config can find what they need.

### 2. Modern LSP Setup

Using native `vim.lsp.enable()` in init.lua rather than the lspconfig plugin is forward-looking. This is the recommended approach for Neovim 0.11+.

### 3. Consistent Style

All plugin files follow the same pattern: return a table of lazy.nvim specs. No mixing of paradigms.

### 4. Good Lazy Loading

Effective use of `ft`, `keys`, and `event` for deferred loading. Examples:

- `purescript-vim` loads only for purescript files
- `undotree` loads only when its keymap is pressed
- `toggleterm` loads its full config upfront but terminals are created on-demand

### 5. Clean Utils Pattern

The `lua/utils.lua` with `set_leader_mappings` reduces boilerplate in navigation.lua.

## Issues and Recommendations

### 1. `tools.lua` is a Catch-All

**Problem:** This file conflates unrelated concerns:

- Git (neogit, gitsigns)
- Debugging (nvim-dap, nvim-dap-ui, nvim-dap-virtual-text)
- Database (vim-dadbod)
- File previews (markdown-preview, asciidoc-preview, csvview)
- Task execution (executor.nvim)
- TODO management (checkmate)

**Options:**

- **Keep as-is** if you prefer fewer files
- **Extract git.lua** with neogit + gitsigns (natural pairing)
- **Extract debug.lua** with the DAP suite

### 2. `interface.lua` is Overloaded

**Problem:** mini.nvim config is ~100 lines configuring 10+ independent modules:

- mini.ai
- mini.icons
- mini.clue
- mini.files
- mini.bracketed
- mini.jump2d
- mini.trailspace
- mini.statusline
- mini.notify
- mini.align

**Options:**

- **Keep as-is** since they're all from one "plugin"
- **Extract mini.lua** dedicated to mini.nvim configuration
- **Split by function** - put mini.files in navigation.lua, mini.statusline stays in interface.lua, etc.

### 3. `terminals.lua` is a Single-Plugin File

**Problem:** Only contains toggleterm.nvim (92 lines). Inconsistent with the "group by function" philosophy.

**Recommendation:** Merge into `interface.lua` or `tools.lua`. The AI agent terminals (Claude, Gemini, OpenCode) are UI-related, so `interface.lua` makes sense.

### 4. `personal.lua` Has ~60% Commented Code

**Problem:** Large blocks of commented-out specs for:

- telescope-quix.nvim
- snow.nvim
- telescope-docker.nvim
- telescope-kafka.nvim

**Recommendation:** Either:

- Delete commented code (it's in version control if needed)
- Move to a separate `personal-archive.lua` that isn't loaded
- Use `enabled = false` in the spec instead of commenting

### 5. Minor: Duplicate Description

In `personal.lua:22`, both `jl` and `ja` mappings have `desc = 'JJ Log'`:

```lua
{ keys = 'jl', fn = neojj.jj_log, desc = 'JJ Log' },
{ keys = 'ja', fn = neojj.jj_annotate, desc = 'JJ Log' },  -- should be 'JJ Annotate'
```

## LSP Diagnostic Warnings

The `vim` undefined global warnings in ftplugin files are lua_ls noise. Two fixes:

### Option A: Per-file suppression

Add to top of each ftplugin file:

```lua
---@diagnostic disable: undefined-global
```

### Option B: Configure lua_ls

In your `lsp/lua_ls.lua` (or wherever lua_ls is configured):

```lua
settings = {
  Lua = {
    diagnostics = {
      globals = { 'vim' }
    }
  }
}
```

## Suggested Reorganization (Optional)

If you want to address the issues above, here's one approach:

```
lua/plugins/
├── completion.lua   # unchanged
├── editing.lua      # unchanged
├── git.lua          # NEW: neogit, gitsigns (from tools.lua)
├── interface.lua    # add toggleterm, remove nothing
├── languages.lua    # unchanged
├── navigation.lua   # unchanged
├── personal.lua     # remove commented code
└── tools.lua        # dap, dadbod, executor, previews (smaller)
```

Delete `terminals.lua`, merge into `interface.lua`.

## Plugin Count Summary

| File           | Plugins  | Lines |
| -------------- | -------- | ----- |
| completion.lua | 1        | 81    |
| editing.lua    | 6        | 117   |
| interface.lua  | 4        | 170   |
| languages.lua  | 5        | 82    |
| navigation.lua | 4        | 124   |
| personal.lua   | 2 active | 155   |
| terminals.lua  | 1        | 92    |
| tools.lua      | 11       | 176   |

**Total: ~34 plugins across 8 files**

## Conclusion

The organization is solid. The main actionable items are:

1. Fix the duplicate `desc` in personal.lua
2. Consider cleaning up commented code in personal.lua
3. Consider merging terminals.lua into interface.lua
4. Fix lua_ls `vim` global warnings if they bother you

The rest is matter of taste. The current structure works.
