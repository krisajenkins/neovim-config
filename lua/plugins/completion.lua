-- Native 0.12 autocomplete: buffer/path/etc. sources without a trigger key
vim.o.autocomplete = true

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
