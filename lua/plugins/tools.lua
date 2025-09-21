return {
    { -- Magit
        'krisajenkins/neogit',
        dir = '/Users/krisjenkins/Work/ThirdParty/neogit',
        dev = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        },
        event = 'VeryLazy',
        config = function()
            require('neogit').setup({})
            vim.keymap.set(
                'n',
                '<Leader>gs',
                ':Neogit cwd=%:p:h<CR>',
                { desc = 'Git [S]tatus', noremap = true }
            )
        end,
    },

    { -- Git Status hints in the left of the buffer
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '│' },
                delete = { text = '-' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '?' },
            },
        },
    },

    {
        -- Floating terminal window(s)
        -- If this gets removed, consider keeping the keyboard bindings!
        'voldikss/vim-floaterm',
        config = function()
            vim.g.floaterm_width = 0.9
            vim.g.floaterm_height = 0.9
            vim.g.floaterm_title = 'Terminal'
            vim.keymap.set('n', '<leader>f', ':FloatermNew fzf<CR>')
            vim.keymap.set({ 'n' }, '<C-e>', ':FloatermToggle<CR>', { desc = 'Floatterm Toggle' })
            vim.keymap.set(
                't',
                '<C-e>',
                '<C-\\><C-n>:FloatermToggle<CR>',
                { desc = 'Floatterm Toggle' }
            )
        end,
    },

    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', ':UndotreeToggle<CR>', desc = 'Undo tree' },
        },
    },

    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            -- dap.set_log_level('TRACE')
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
            vim.keymap.set(
                'n',
                '<Leader>db',
                dap.toggle_breakpoint,
                { desc = '[D]ebug [B]reakpoint' }
            )
            vim.keymap.set('n', '<Leader>dr', dap.repl.toggle, { desc = '[D]ebug [R]epl' })
            vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
            vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = '[D]ebug step [O]ver' })
            vim.keymap.set('n', '<Leader>du', dap.step_out, { desc = '[D]ebug step o[U]t' })
            vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = '[D]ebug step [I]nto' })
        end,
    },

    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
            local dapui = require('dapui')
            dapui.setup()
            vim.keymap.set('n', '<Leader>dp', dapui.toggle, { desc = '[D]ebug [P]anels' })
            vim.keymap.set('n', '<Leader>dh', function()
                dapui.float_element('scopes')
            end, { desc = '[D]ebug [H]over scopes' })
        end,
    },

    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = { 'mfussenegger/nvim-dap' },
        opts = {},
    },

    { -- Database tools
        'tpope/vim-dadbod',
        event = 'VeryLazy',
        config = function() end,
    },

    { 'akinsho/toggleterm.nvim', version = '*', config = true },

    {
        'google/executor.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        event = 'VeryLazy',
        config = function()
            local executor = require('executor')
            executor.setup { use_split = false }
            vim.keymap.set('n', '<leader>xr', executor.commands.run, { desc = 'e[X]ecutor [R]un' })
            vim.keymap.set(
                'n',
                '<leader>xv',
                executor.commands.toggle_detail,
                { desc = 'e[X]ecutor [V]iew' }
            )
        end,
    },

    {
        'https://codeberg.org/esensar/nvim-dev-container',
        event = 'VeryLazy',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
    },

    {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },

    {
        'tigion/nvim-asciidoc-preview',
        cmd = { 'AsciiDocPreview' },
        ft = { 'asciidoc' },
        build = 'cd server && npm install',
        opts = {
            -- Add user configuration here
        },
    },

    {
        -- Nice formatting for TODO.md files.
        'bngarren/checkmate.nvim',
        ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
        opts = {
            -- your configuration here
            -- or leave empty to use defaults
            files = {
                'todo',
                'TODO',
                'todo.md',
                'TODO.md',
                'TODO*.md',
            },
        },
    },
}
