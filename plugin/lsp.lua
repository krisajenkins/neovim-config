vim.lsp.enable({
    'lua_ls',
    'hls',
    'clangd',
    'zls',
    'nil_ls',
    'jdtls',
    'gleam',
    'arduino_language_server',
    'toit',
    'rust_analyzer',
    'erlangls',
    'mojo',
    'purescriptls',
    'ts_ls',
    'svelte',
    'pylsp',
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        -- Defaults in 0.12: gd, gD, K, gri, grr, grn, gra, grt, grx, [d, ]d
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<Leader>wl', function()
            vim.print(vim.lsp.buf.list_workspace_folders())
        end, opts)
        vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
    end,
})
