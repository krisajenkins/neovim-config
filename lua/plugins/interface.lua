return {
    { 'tomasr/molokai' },
    { 'ellisonleao/gruvbox.nvim' },

    'MunifTanjim/nui.nvim',

    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            -- require('mini.indentscope').setup()
            require('mini.ai').setup()
            require('mini.starter').setup()
            -- mini.icons setup - provides nvim-web-devicons compatibility
            local miniicons = require('mini.icons')
            miniicons.setup({
                -- Use 'glyph' style for Nerd Font icons
                style = 'glyph',
            })
            -- Enable nvim-web-devicons compatibility
            miniicons.mock_nvim_web_devicons()

            local miniclue = require('mini.clue')
            miniclue.setup({
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            })

            local minifiles = require('mini.files')
            minifiles.setup({
                windows = {
                    preview = false,
                    width_preview = 60,
                },
            })
            vim.keymap.set('n', '-', function()
                minifiles.open(vim.api.nvim_buf_get_name(0))
            end, { desc = 'MiniFiles Open' })

            -- Custom mappings for mini.files
            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Override 'l' to close mini.files when opening a file
                    vim.keymap.set('n', 'l', function()
                        local entry = minifiles.get_fs_entry()
                        if entry then
                            if entry.fs_type == 'file' then
                                minifiles.close()
                                vim.cmd('edit ' .. vim.fn.fnameescape(entry.path))
                            else
                                -- For directories, use the default behavior (navigate into)
                                minifiles.go_in()
                            end
                        end
                    end, { buffer = buf_id, desc = 'Open file (and close)' })

                    -- 'L' opens file in split
                    vim.keymap.set('n', 'L', function()
                        local entry = minifiles.get_fs_entry()
                        if entry and entry.fs_type == 'file' then
                            minifiles.close()
                            vim.cmd('vsplit ' .. vim.fn.fnameescape(entry.path))
                        end
                    end, { buffer = buf_id, desc = 'Open in split' })
                end,
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

            require('mini.trailspace').setup({
                only_in_normal_buffers = true,
            })

            require('mini.statusline').setup()

            require('mini.notify').setup()

            require('mini.align').setup()
        end,
    },

    {
        'folke/trouble.nvim', -- Error list.
        dependencies = { 'echasnovski/mini.nvim' },
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
