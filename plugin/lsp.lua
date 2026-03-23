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
    'pylsp',
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<Leader>wl', function()
            vim.print(vim.lsp.buf.list_workspace_folders())
        end, opts)
        vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({ count = -1 })
        end, opts)
        vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({ count = 1 })
        end, opts)
    end,
})
