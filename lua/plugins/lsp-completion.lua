return {
    { -- Popular LSP configurations
        'neovim/nvim-lspconfig',

        config = function()
            -- See `:help lspconfig-all` for the list of available language servers.
            local lspconfig = require('lspconfig')
            vim.lsp.set_log_level('off')

            lspconfig.lua_ls.setup({
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if
                        vim.loop.fs_stat(path .. '/.luarc.json')
                        or vim.loop.fs_stat(path .. '/.luarc.jsonc')
                    then
                        return
                    end

                    client.config.settings.Lua =
                        vim.tbl_deep_extend('force', client.config.settings.Lua, {
                            runtime = {
                                -- Tell the language server which version of Lua you're using
                                -- (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                            },
                            -- Make the server aware of Neovim runtime files
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    -- Depending on the usage, you might want to add additional paths here.
                                    -- "${3rd}/luv/library"
                                    -- "${3rd}/busted/library",
                                },
                                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                                -- library = vim.api.nvim_get_runtime_file("", true)
                            },
                        })
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    },
                },
            })

            lspconfig.hls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.zls.setup({})
            lspconfig.gleam.setup({})
            lspconfig.arduino_language_server.setup({})

            local configs = require('lspconfig.configs')

            if not configs.toit then
                configs.toit = {
                    default_config = {
                        cmd = { 'jag', 'toit', 'lsp' },
                        root_dir = lspconfig.util.root_pattern('.git'),
                        filetypes = { 'toit' },
                    },
                }
            end
            lspconfig.toit.setup({})

            -- NOTE: You may need to call `rustup component add rust-analyzer` for this to work.
            -- "/Users/krisjenkins/.rustup/toolchains/stable-aarch64-apple-darwin/bin/rust-analyzer",
            lspconfig.rust_analyzer.setup({
                -- cmd = {
                --     '/Users/krisjenkins/.rustup/toolchains/esp/bin/rust-analyzer',
                -- },
                -- settings = {
                --     ['rust-analyzer'] = {
                --         server = { extraEnv = { RUSTUP_TOOLCHAIN = 'stable' } },
                --         cargo = {
                --             extraEnv = {
                --                 ['RUSTUP_TOOLCHAIN'] = 'stable',
                --             },
                --         },
                --         diagnostics = {
                --             enable = false,
                --         },
                --     },
                -- },
            })

            -- lspconfig.pylsp.setup({})

            lspconfig.erlangls.setup {}
            lspconfig.mojo.setup({})
            lspconfig.purescriptls.setup({
                root_dir = lspconfig.util.root_pattern('spago.dhall', 'spago.yaml'),
                settings = {
                    purescript = {
                        addSpagoSources = true,
                        formatter = 'purty',
                    },
                },
            })

            lspconfig.ts_ls.setup({})

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { title = 'Docs', border = 'rounded', max_width = 100 }
            )

            -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show symbol info' })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
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
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')
            lspconfig.pylsp.setup({
                capabilities = capabilities,
            })
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