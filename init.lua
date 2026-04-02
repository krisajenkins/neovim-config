------------------------------------------------------------
-- Core key mappings and options.
------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>', { noremap = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.opt.diffopt = 'iwhite,filler,context:20,algorithm:histogram,inline:word'
vim.opt.pumborder = 'single'
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
-- Plugins (vim.pack)
------------------------------------------------------------
require('config.pack')

------------------------------------------------------------
-- Extra Config.
------------------------------------------------------------

-- Colorscheme
require('vim._core.ui2').enable({})
vim.cmd('colorscheme molokai')
-- vim.cmd('colorscheme gruvbox')

-- Diagnostics are now handled by LSP plugin mappings
vim.keymap.set('n', '<Leader>m', ':write<CR>:make<CR>', { desc = '[M]ake' })
vim.keymap.set('n', '<Leader>u', ':Undotree<CR>', { desc = '[U]ndo tree' })

-- Syntax highlighting customisation.
vim.api.nvim_set_hl(0, 'Comment', { link = 'String' })
vim.api.nvim_set_hl(0, 'IncSearch', { link = 'CurSearch' })
vim.api.nvim_set_hl(0, '@org.keyword.todo', { link = 'PreProc' })

-- Show user-placed marks in the signcolumn (Neovim 0.12 MarkSet event)
vim.api.nvim_create_autocmd('MarkSet', {
    desc = 'Display marks in the signcolumn',
    callback = function(ev)
        local mark = ev.data and ev.data.mark
        if not mark or not mark:match('^[a-zA-Z]$') then
            return
        end
        local pos = vim.api.nvim_buf_get_mark(ev.buf, mark)
        if pos[1] == 0 then
            return
        end
        local name = 'UserMark_' .. mark
        vim.fn.sign_define(name, { text = mark, texthl = 'Identifier' })
        vim.fn.sign_unplace('UserMarks', { buffer = ev.buf, id = mark:byte() })
        vim.fn.sign_place(mark:byte(), 'UserMarks', name, ev.buf, { lnum = pos[1], priority = 10 })
    end,
})

vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    desc = 'Open quickfix window if there are results.',
    pattern = '[^l]*',
    callback = function()
        vim.cmd.cwindow()
    end,
})

vim.keymap.set('n', '<leader>v', function()
    vim.cmd(':wall')
    vim.cmd(':mksession! /tmp/nvim-restart.vim')
    vim.cmd(':restart -S /tmp/nvim-restart.vim')
end, { desc = "Run the thing you're de[V]eloping" })
