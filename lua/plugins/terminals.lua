return {
    {
        -- Floating terminal window(s)
        'akinsho/toggleterm.nvim',
        version = '*',
        config = function()
            require('toggleterm').setup({
                size = function(term)
                    if term.direction == 'horizontal' then
                        return 15
                    elseif term.direction == 'vertical' then
                        return vim.o.columns * 0.4
                    end
                end,
                open_mapping = nil, -- We'll use custom mappings
                hide_numbers = true,
                shade_terminals = true,
                start_in_insert = true,
                insert_mappings = false,
                terminal_mappings = true,
                persist_size = true,
                persist_mode = true,
                direction = 'float',
                close_on_exit = true,
                shell = vim.o.shell,
                auto_scroll = true,
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
            vim.keymap.set(
                { 'n', 't' },
                '<C-e>',
                '<Cmd>1ToggleTerm<CR>',
                { desc = 'Toggle Shell Terminal' }
            )

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

            -- Even shorter keymap for my current preferred agent.
            vim.keymap.set({ 'n', 't' }, '<C-,>', function()
                claude_term:toggle()
            end, { desc = 'Toggle Claude' })
        end,
    },
}
