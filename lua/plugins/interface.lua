return {
    { 'tomasr/molokai' },
    { 'ellisonleao/gruvbox.nvim' },

    {
        'grapp-dev/nui-components.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
    },

    'nvim-tree/nvim-web-devicons', -- Pretty fonticons.
    'MunifTanjim/nui.nvim',

    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            -- require('mini.indentscope').setup()
            require('mini.ai').setup()
            require('mini.starter').setup()
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

            require('mini.trailspace').setup({
                only_in_normal_buffers = true,
            })

            require('mini.statusline').setup()

            require('mini.notify').setup()

            require('mini.align').setup()
        end,
    },

    { -- Suggest keyboard shortcuts
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            local which = require('which-key')
            which.setup()
            which.add({
                { '<leader>g', group = '[G]o to' },
                { '<leader>k', group = '[K]afka & doc[K]er' },
                { '<leader>l', group = '[L]azy' },
                { '<leader>x', group = 'e[X]ecutor' },
                { '<leader>d', group = '[D]ev' },
            })
        end,
    },

    {
        'folke/trouble.nvim', -- Error list.
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            focus = false,
            modes = {
                diagnostics = {
                    auto_close = true,
                },
            },
        },
        keys = {
            {
                '<Leader>ge',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
        },
    },

    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            local ufo = require('ufo')
            ufo.setup {
                provider_selector = function()
                    return { 'treesitter', 'indent' }
                end,
            }

            vim.opt.foldcolumn = '0' -- '0' is not bad
            vim.opt.foldlevel = 99 -- Using ufo provider needs a large value, feel free to decrease the value
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true
        end,
    },
}
