-- Neogit (dev plugin)
require('neogit').setup({})
vim.keymap.set(
    'n',
    '<Leader>gs',
    ':Neogit cwd=%:p:h<CR>',
    { desc = 'Git [S]tatus', noremap = true }
)

-- Gitsigns
require('gitsigns').setup({
    signs = {
        add = { text = '+' },
        change = { text = '│' },
        delete = { text = '-' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '?' },
    },
})

-- DAP (Debug Adapter Protocol)
local dap = require('dap')
dap.adapters.python = {
    type = 'executable',
    command = 'python',
    args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
    {
        type = 'python',
        name = 'Launch File',
        request = 'launch',
        program = '${file}',
    },
}
vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = '[D]ebug [B]reakpoint' })
vim.keymap.set('n', '<Leader>dr', dap.repl.toggle, { desc = '[D]ebug [R]epl' })
vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = '[D]ebug step [O]ver' })
vim.keymap.set('n', '<Leader>du', dap.step_out, { desc = '[D]ebug step o[U]t' })
vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = '[D]ebug step [I]nto' })

-- DAP UI
local dapui = require('dapui')
dapui.setup()
vim.keymap.set('n', '<Leader>dp', dapui.toggle, { desc = '[D]ebug [P]anels' })
vim.keymap.set('n', '<Leader>dh', function()
    dapui.float_element('scopes')
end, { desc = '[D]ebug [H]over scopes' })

-- DAP Virtual Text
require('nvim-dap-virtual-text').setup({})

-- Executor
local executor = require('executor')
executor.setup({ use_split = false })
vim.keymap.set('n', '<leader>xr', executor.commands.run, { desc = 'e[X]ecutor [R]un' })
vim.keymap.set('n', '<leader>xv', executor.commands.toggle_detail, { desc = 'e[X]ecutor [V]iew' })

-- Checkmate (TODO.md formatting)
require('checkmate').setup({
    files = {
        'todo',
        'TODO',
        'todo.md',
        'TODO.md',
        'TODO*.md',
    },
})

-- CSV viewer
require('csvview').setup({
    view = {
        display_mode = 'border',
    },
    keymaps = {
        jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
        jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
        textobject_field_inner = { 'if', mode = { 'o', 'x' } },
        textobject_field_outer = { 'af', mode = { 'o', 'x' } },
    },
})
