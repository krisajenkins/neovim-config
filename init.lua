------------------------------------------------------------
-- Core key mappings and options.
------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>', { noremap = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.do_filetype_lua = 1

vim.opt.diffopt = 'iwhite,filler,context:20,algorithm:histogram,inline:word'
vim.opt.pumborder = true
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
vim.opt.grepprg = 'rg --vimgrep --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

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
require('vim._core.ui2').enable()
vim.cmd('colorscheme molokai')
-- vim.cmd('colorscheme gruvbox')

-- Diagnostics are now handled by LSP plugin mappings
vim.keymap.set('n', '<Leader>m', ':write<CR>:make<CR>', { desc = '[M]ake' })

-- Syntax highlighting customisation.
vim.api.nvim_set_hl(0, 'Comment', { link = 'String' })
vim.api.nvim_set_hl(0, 'IncSearch', { link = 'CurSearch' })
vim.api.nvim_set_hl(0, '@org.keyword.todo', { link = 'PreProc' })

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    desc = 'Open quickfix window if there are results.',
    pattern = '[^l]*',
    callback = function()
        vim.cmd.cwindow()
    end,
})

vim.keymap.set('n', '<leader>v', function()
    vim.cmd(':wall')
    vim.cmd(':source')
end, { desc = "Run the thing you're de[V]eloping" })
