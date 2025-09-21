return {
    { -- Popular LSP configurations
        'neovim/nvim-lspconfig',

        config = function()
            -- Using the new Neovim 0.11 LSP configuration API
            vim.lsp.set_log_level('off')

            -- Neovim 0.11 automatically discovers and loads configs from lsp/ directory
            -- Just enable the servers we want to use
            vim.lsp.enable({
                'lua_ls',
                'hls',
                'clangd',
                'zls',
                'nil_ls',
                'jdtls',
                'gleam',
                'arduino_language_server',
                'toit',
                'rust_analyzer',
                'erlangls',
                'mojo',
                'purescriptls',
                'ts_ls',
                'pylsp',
            })

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { title = 'Docs', border = 'rounded', max_width = 100 }
            )

            -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show symbol info' })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
            vim.keymap.set(
                'n',
                '<Leader>lt',
                vim.lsp.buf.typehierarchy,
                { desc = '[L]sp [T]ype hierarchy' }
            )
            vim.keymap.set(
                'n',
                '<Leader>lm',
                vim.lsp.buf.implementation,
                { desc = '[L]sp i[M]plementation' }
            )
            vim.keymap.set(
                'n',
                '<Leader>li',
                vim.lsp.buf.incoming_calls,
                { desc = '[L]sp [I]ncoming calls' }
            )
            vim.keymap.set(
                'n',
                '<Leader>lo',
                vim.lsp.buf.outgoing_calls,
                { desc = '[L]sp [O]utgoing calls' }
            )
            vim.keymap.set(
                'n',
                '<Leader>lr',
                vim.lsp.buf.references,
                { desc = '[L]sp [R]eferences' }
            )
            vim.keymap.set('n', '<Leader>lR', vim.lsp.buf.rename, { desc = '[L]sp [R]ENAME' })
            vim.keymap.set({ 'n', 'v' }, '<C-c><C-k>', vim.lsp.buf.code_action)
        end,
    },

    {
        'hrsh7th/nvim-cmp',
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
                    { name = 'vsnip' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                }),
            })
            -- Note: Individual LSP servers can be configured with capabilities
            -- by adding them to their respective configuration files in lsp/
        end,
    },

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',

    -- { 'L3MON4D3/LuaSnip' },

    { 'folke/neodev.nvim', opts = {} },
}
