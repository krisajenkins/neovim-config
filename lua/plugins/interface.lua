-- Mini modules
require('mini.ai').setup()

local miniicons = require('mini.icons')
miniicons.setup({ style = 'glyph' })
miniicons.mock_nvim_web_devicons()

local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'i', keys = '<C-x>' },
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },
    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

require('mini.bracketed').setup()

local MiniJump2d = require('mini.jump2d')
local single_character = MiniJump2d.builtin_opts.single_character
MiniJump2d.setup({
    view = { dim = true },
    spotter = single_character.spotter,
    hooks = { after_jump = single_character.hooks.after_jump },
    mappings = { start_jumping = '' },
    silent = true,
})
vim.keymap.set('n', '<Leader>w', function()
    MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = 'Jump to Char' })

require('mini.trailspace').setup({ only_in_normal_buffers = true })
require('mini.statusline').setup()
require('mini.notify').setup()
require('mini.align').setup()

-- Trouble (error list)
require('trouble').setup({
    focus = false,
    modes = {
        diagnostics = { auto_close = true },
    },
})
vim.keymap.set(
    'n',
    '<Leader>ge',
    '<cmd>Trouble diagnostics toggle<cr>',
    { desc = 'Diagnostics (Trouble)' }
)

-- Folding
local ufo = require('ufo')
ufo.setup({
    provider_selector = function()
        return { 'treesitter', 'indent' }
    end,
})
vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
