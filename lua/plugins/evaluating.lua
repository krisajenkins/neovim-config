-- highlight CursorH guibg=lightgreen
-- set guicursor=n-v-c-i:block-CursorH
-- let g:neovide_cursor_trail_size=0
-- let g:neovide_cursor_animation_length=0.3
------------------------------------------------------------
-- This is a staging area. Plugins that have yet to prove themselves essential.
------------------------------------------------------------

return {
    {
        'tigion/nvim-asciidoc-preview',
        cmd = { 'AsciiDocPreview' },
        ft = { 'asciidoc' },
        build = 'cd server && npm install',
        opts = {
            -- Add user configuration here
        },
    },
    { 'shaunsingh/nord.nvim' },
    {
        -- Floating terminal window(s)
        -- If this gets removed, consider keeping the keyboard bindings!
        'voldikss/vim-floaterm',
        config = function()
            vim.keymap.set('n', '<leader>f', ':FloatermNew fzf<CR>')
            vim.keymap.set(
                { 'i', 'n' },
                '<C-e>',
                ':FloatermToggle<CR>',
                { desc = 'Floatterm Toggle' }
            )
            vim.keymap.set(
                't',
                '<C-e>',
                '<C-\\><C-n>:FloatermToggle<CR>',
                { desc = 'Floatterm Toggle' }
            )
        end,
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
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
    {
        'https://codeberg.org/esensar/nvim-dev-container',
        event = 'VeryLazy',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
    },
    { -- Database tools
        'tpope/vim-dadbod',
        event = 'VeryLazy',
        config = function() end,
    },
    {
        'dawsers/edit-code-block.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'Wansmer/treesj',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'natecraddock/workspaces.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        event = 'VeryLazy',
        opts = {},
        config = function()
            require('telescope').load_extension('workspaces')
            require('workspaces').setup({
                hooks = {
                    open = { 'Neotree', 'Telescope find_files' },
                },
            })
        end,
        keys = { { '<Leader>gw', ':Telescope workspaces<CR>', desc = 'browse [W]orkspaces' } },
    },
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
    { 'akinsho/toggleterm.nvim', version = '*', config = true },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            dap.set_log_level('TRACE') -- TODO KAJ
            dap.configurations.lua = {
                {
                    name = 'Attach to running Neovim instance.',
                    type = 'nlua',
                    request = 'attach',
                    -- cwd = '${workspaceFolder}',
                    -- program = {
                    --     lua = 'lua5.1',
                    --     file = '${file}',
                    -- },
                    -- args = {},
                },
            }
            dap.adapters.nlua = function(callback, config)
                callback({
                    type = 'server',
                    host = config.host or '127.0.0.1',
                    port = config.port or 8086,
                })
            end
            vim.keymap.set(
                'n',
                '<Leader>db',
                dap.toggle_breakpoint,
                { desc = '[D]ebug [B]reakpoint' }
            )
            vim.keymap.set({ 't', 'n' }, '<Leader>dr', dap.repl.toggle, { desc = '[D]ebug [R]epl' })
            vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
            vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = '[D]ebug step [O]ver' })
            vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = '[D]ebug step [I]nto' })
            local widgets = require('dap.ui.widgets')
            vim.keymap.set('n', '<Leader>dh', function()
                local my_sidebar = widgets.sidebar(widgets.scopes)
                my_sidebar.open()
            end, { desc = '[D]ebug [H]over' })
            vim.keymap.set('n', '<Leader>dl', function()
                local osv = require('osv')
                osv.run_this()
            end, { desc = '[D]ebug [L]aunch' })
        end,
    },
    { 'jbyuki/one-small-step-for-vimkind', dependencies = { 'mfussenegger/nvim-dap' } },
    {
        'hrsh7th/nvim-cmp',
        event = 'VeryLazy',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig',
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                view = {
                    entries = { name = 'custom', selection_order = 'near_cursor' },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                completion = { completeopt = 'menu,menuone,noinsert' },

                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.confirm { select = true },
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                }),
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig')['lua_ls'].setup { capabilities = capabilities }
            require('lspconfig')['pylsp'].setup { capabilities = capabilities }
        end,
    },
    {
        'renerocksai/telekasten.nvim',
        event = 'VeryLazy',
        config = function()
            local telekasten = require('telekasten')
            telekasten.setup({
                home = vim.fn.expand('~/telekasten'),
            })
        end,
        keys = {
            {
                '<Leader>n',
                ':Telekasten panel<CR>',
                desc = 'Telekasten panel',
            },
        },
    },
    {
        -- Org Mode
        -- Useful shortcuts: https://nvim-orgmode.github.io/features.html
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter' },
        },
        ft = 'org',
        config = function()
            -- Load treesitter grammar for org
            local orgmode = require('orgmode')
            -- Setup orgmode
            orgmode.setup({
                org_agenda_files = '~/orgfiles/**/*',
                org_default_notes_file = '~/orgfiles/refile.org',
            })
            orgmode.setup_ts_grammar()
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },
}
