-- Native 0.12 autocomplete: buffer/path/etc. sources without a trigger key
vim.o.autocomplete = true

-- Telescope is itself a fuzzy-finder, so the native popup just fights it.
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('UserNoAutocompleteInTelescope', {}),
    pattern = 'TelescopePrompt',
    callback = function(ev)
        vim.bo[ev.buf].autocomplete = false
    end,
})

-- Don't auto-select or auto-insert a popup item: only <C-n>/<C-p> should
-- choose a completion, and only <C-y>/<Tab> should accept it. Without
-- noinsert/noselect, typing any non-popup key (e.g. '.') accepts the
-- currently highlighted match — see :help ins-completion-menu.
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect', 'popup', 'fuzzy' }

-- Include 'omnifunc' (= LSP, set on LspAttach) as a native autocomplete
-- source, so LSP results appear alongside buffer/path/tag matches.
vim.opt.complete:append('o')

-- Built-in LSP completion (Neovim 0.12+)
-- Enabled per-buffer via LspAttach, auto-triggers as you type
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspCompletion', {}),
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
        })
    end,
})

-- Use Tab to accept the selected completion item
vim.keymap.set('i', '<Tab>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-y>'
    end
    return '<Tab>'
end, { expr = true })
