------------------------------------------------------------
-- Core key mappings and options.
------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>', { noremap = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.do_filetype_lua = 1

vim.opt.diffopt = 'iwhite,filler,context:20,algorithm:histogram'
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
vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

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
require('config.lazy')
vim.keymap.set('n', '<Leader>lp', ':Lazy profile<CR>', { desc = '[L]azy [P]rofile' })

------------------------------------------------------------
-- Extra Config.
------------------------------------------------------------

-- Colorscheme
vim.cmd('colorscheme molokai')
-- vim.cmd('colorscheme gruvbox')

-- Diagnostics are now handled by LSP plugin mappings
vim.keymap.set('n', '<Leader>m', ':write<CR>:make<CR>', { desc = '[M]ake' })

-- Syntax highlighting customisation.
vim.api.nvim_set_hl(0, 'Comment', { link = 'String' })
vim.api.nvim_set_hl(0, 'IncSearch', { link = 'CurSearch' })
vim.api.nvim_set_hl(0, '@org.keyword.todo', { link = 'PreProc' })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yanked text with a brief flash.',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    desc = 'Open quickfix window if there are results.',
    pattern = '[^l]*',
    callback = function()
        vim.cmd.cwindow()
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

-- LSP servers are configured using the new vim.lsp.enable() API
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

-- LSP key mappings
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
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end,
})
