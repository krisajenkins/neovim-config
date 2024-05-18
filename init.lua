------------------------------------------------------------
-- Core key mappings and options.
------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>', { noremap = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.do_filetype_lua = 1

vim.opt.diffopt = 'iwhite,filler'
vim.opt.exrc = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = true
vim.opt.number = false
vim.opt.ruler = true
vim.opt.showbreak = '↪'
vim.opt.linebreak = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.conceallevel = 0

vim.opt.breakindent = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

------------------------------------------------------------
-- Lazy Plugins
------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins', {
    dev = {
        path = '/Users/krisjenkins/.config/nvim/dev/',
    },
})

------------------------------------------------------------
-- Extra Config.
------------------------------------------------------------

-- Colorscheme
vim.cmd('colorscheme molokai')

-- Diagnostics.
vim.keymap.set('n', '©p', vim.diagnostic.goto_prev)
vim.keymap.set('n', '©n', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>lp', ':Lazy profile<CR>', { desc = '[L]azy [P]rofile' })

-- Syntax highlighting customisation.
vim.api.nvim_set_hl(0, 'Comment', { link = 'String' })
vim.api.nvim_set_hl(0, '@org.keyword.todo', { link = 'PreProc' })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yanked text with a brief flash.',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set('n', '<leader>tt', ':edit term://zsh<CR>', { desc = 'Open a [T]erminal' })
vim.keymap.set('n', '<leader>v', function()
    vim.cmd(':wall')
    vim.cmd(':source')
    -- require('plenary.reload').reload_module('telescope_kafka.stream_component')
    -- require('plenary.reload').reload_module('telescope_kafka.stream')
    -- require('telescope_kafka.stream').run()
end, { desc = "Run the thing you're de[V]eloping" })

-- vim.keymap.set('n', '<C-e>', [[:terminal<CR>]])
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            -- vim.keymap.set('t', '<C-e>', [[<C-\><C-n>]], opts)
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


