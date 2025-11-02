vim.keymap.set('n', '<leader>tt', ':edit term://zsh<CR>', { desc = 'Open a [T]erminal' })

vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end

        -- Go into append mode straight away.
        vim.cmd('startinsert!')
    end,
})
