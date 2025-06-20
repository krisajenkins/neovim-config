return {
    { -- Everything browser
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local utils = require('utils')
            local set_leader_mappings = utils.set_leader_mappings
            local telescope = require('telescope')
            telescope.setup {
                defaults = {
                    path_display = { 'smart' },
                    wrap_results = true,
                    prompt_prefix = '🔍 ',
                    layout_config = {
                        horizontal = {
                            preview_width = 0.5,
                        },
                    },
                    tiebreak = function(current_entry, existing_entry)
                        return (current_entry[1]:lower() < existing_entry[1]:lower())
                    end,
                },
            }

            local builtin = require('telescope.builtin')

            pcall(telescope.load_extension, 'fzf')
            pcall(telescope.load_extension, 'ui-select')

            set_leader_mappings {
                { keys = 'gf', fn = builtin.find_files, desc = '[F]ile finder' },
                { keys = 'gm', fn = builtin.marks, desc = '[M]arks' },
                { keys = 'gg', fn = builtin.live_grep, desc = 'Live [G]rep' },
                { keys = 'gb', fn = builtin.buffers, desc = '[B]uffer finder' },
                { keys = 'gk', fn = builtin.keymaps, desc = '[B]uffer finder' },
                { keys = 'ga', fn = builtin.resume, desc = 'Go [A]gain (resume previous search)' },
                { keys = 'go', fn = builtin.oldfiles, desc = '[O]ld files' },
                { keys = 'gh', fn = builtin.help_tags, desc = '[H]elp (manual)' },
                { keys = 'gi', fn = ':edit ~/.config/nvim/init.lua<CR>', desc = '[I]nit.lua' },
                {
                    keys = 'gp',
                    fn = ':edit ~/.config/nvim/lua/plugins/<CR>',
                    desc = '[P]lugins directory',
                },
                {
                    keys = 'ds',
                    fn = builtin.lsp_document_symbols,
                    desc = '[D]ev document [S]ymbols',
                },
                { keys = 'dd', fn = builtin.lsp_definitions, desc = '[D]ev [D]efinitions' },
            }
        end,
        keys = {
            {
                '<Leader>gv',
                function()
                    local builtin = require('telescope.builtin')
                    builtin.find_files({ cwd = vim.fn.stdpath 'config' })
                end,
                desc = 'n[V]im config',
            },
            {
                '<Leader>s',
                function()
                    local builtin = require('telescope.builtin')
                    local themes = require('telescope.themes')

                    builtin.current_buffer_fuzzy_find(themes.get_dropdown({
                        winblend = 10,
                        previewer = false,
                    }))
                end,
                desc = '[/] Fuzzily search in current buffer',
            },
        },
    },

    'nvim-telescope/telescope-ui-select.nvim',

    -- {
    --     'debugloop/telescope-undo.nvim',
    --     dependencies = { -- note how they're inverted to above
    --         {
    --             'nvim-telescope/telescope.nvim',
    --             dependencies = { 'nvim-lua/plenary.nvim' },
    --         },
    --     },
    --     keys = {
    --         { -- lazy style key map
    --             '<leader>u',
    --             '<cmd>Telescope undo<cr>',
    --             desc = 'undo history',
    --         },
    --     },
    --     opts = {
    --         -- don't use `defaults = { }` here, do this in the main telescope spec
    --         extensions = {
    --             undo = {
    --                 -- telescope-undo.nvim config, see below
    --             },
    --         },
    --     },
    --     config = function(_, opts)
    --         -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    --         -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    --         -- defaults, as well as each extension).
    --         require('telescope').setup(opts)
    --         require('telescope').load_extension('undo')
    --     end,
    -- },

    { -- dired+
        'elihunter173/dirbuf.nvim',
    },

}
