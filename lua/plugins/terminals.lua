require('toggleterm').setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = nil,
    hide_numbers = true,
    shade_terminals = false,
    auto_scroll = false,
    start_in_insert = true,
    insert_mappings = false,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'curved',
        width = function()
            return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
            return math.floor(vim.o.lines * 0.9)
        end,
        winblend = 0,
        title_pos = 'center',
    },
})

local Terminal = require('toggleterm.terminal').Terminal

-- Terminal 1: Main shell
vim.keymap.set({ 'n', 't' }, '<C-e>', '<Cmd>1ToggleTerm<CR>', { desc = 'Toggle Shell Terminal' })

-- Claude agent
local claude_term = Terminal:new({
    cmd = 'claude',
    count = 2,
    display_name = ' Claude ',
    direction = 'float',
})

vim.keymap.set({ 'n', 't' }, '<leader>ac', function()
    claude_term:toggle()
end, { desc = 'Toggle Claude' })

-- Gemini agent
local gemini_term = Terminal:new({
    cmd = 'gemini',
    count = 3,
    display_name = ' Gemini ',
    direction = 'float',
})

vim.keymap.set({ 'n', 't' }, '<leader>ag', function()
    gemini_term:toggle()
end, { desc = 'Toggle Gemini' })

-- OpenCode agent
local opencode_term = Terminal:new({
    cmd = 'opencode',
    count = 4,
    display_name = ' OpenCode ',
    direction = 'float',
})

vim.keymap.set({ 'n', 't' }, '<leader>ao', function()
    opencode_term:toggle()
end, { desc = 'Toggle OpenCode' })

-- claudecode.nvim: MCP/WebSocket integration with the Claude Code CLI.
-- Uses the native terminal provider so we don't depend on snacks.nvim.
-- Keys live under <leader>a but avoid ac/ag/ao (toggleterm agents above).
require('claudecode').setup({
    terminal = {
        provider = 'native',
    },
})

vim.keymap.set({ 'n', 't' }, '<leader>aC', '<Cmd>ClaudeCode<CR>', { desc = 'Toggle ClaudeCode' })
vim.keymap.set('n', '<leader>af', '<Cmd>ClaudeCodeFocus<CR>', { desc = 'Focus ClaudeCode' })
vim.keymap.set('n', '<leader>ar', '<Cmd>ClaudeCode --resume<CR>', { desc = 'Resume ClaudeCode' })
vim.keymap.set(
    'n',
    '<leader>ab',
    '<Cmd>ClaudeCodeAdd %<CR>',
    { desc = 'Add current buffer to ClaudeCode' }
)
vim.keymap.set(
    'v',
    '<leader>as',
    '<Cmd>ClaudeCodeSend<CR>',
    { desc = 'Send selection to ClaudeCode' }
)
vim.keymap.set(
    'n',
    '<leader>am',
    '<Cmd>ClaudeCodeSelectModel<CR>',
    { desc = 'Select ClaudeCode model' }
)
vim.keymap.set(
    'n',
    '<leader>aa',
    '<Cmd>ClaudeCodeDiffAccept<CR>',
    { desc = 'Accept ClaudeCode diff' }
)
vim.keymap.set('n', '<leader>ad', '<Cmd>ClaudeCodeDiffDeny<CR>', { desc = 'Deny ClaudeCode diff' })

-- Even shorter keymap for my current preferred agent.
vim.keymap.set({ 'n', 't' }, '<C-,>', function()
    claude_term:toggle()
end, { desc = 'Toggle Claude' })

-- Send visual selection to the current preferred agent.
vim.keymap.set('v', '<leader>t', function()
    require('toggleterm').send_lines_to_terminal(
        'visual_selection',
        true,
        { args = claude_term.count }
    )
    claude_term:open()
    vim.cmd('startinsert')
end, { desc = 'Send selection to Claude' })
