local set_leader_mappings = require('utils').set_leader_mappings

return {
    {
        -- Theme
        'tomasr/molokai',
    },
    { 'ellisonleao/gruvbox.nvim' },
    {
        'grapp-dev/nui-components.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
    },
    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            -- require('mini.indentscope').setup()
            -- require('mini.starter').setup()

            -- local files = require('mini.files')
            -- files.setup()
            -- vim.keymap.set('n', '-', files.open, { desc = 'Open File Nav' })

            require('mini.trailspace').setup({
                only_in_normal_buffers = true,
            })

            require('mini.statusline').setup()
            require('mini.notify').setup {
                lsp_progress = {
                    duration_last = 2000,
                },
            }
        end,
    },
    { -- Everything browser
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
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
            local themes = require('telescope.themes')

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
                    fn = ':edit ~/.config/nvim/lua/plugins/evaluating.lua<CR>',
                    desc = '[P]lugins.lua',
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
    {
        'mbbill/undotree',
        keys = {
            { '<Leader>u', ':UndotreeToggle<CR>', desc = 'Undo tree' },
        },
    },
    -- { -- Undo tree.
    --     'debugloop/telescope-undo.nvim',
    --     event = 'VeryLazy',
    --     dependencies = {
    --         'nvim-telescope/telescope.nvim',
    --     },
    --     config = function()
    --         require('telescope').load_extension('undo')
    --     end,
    --     keys = {
    --         { '<Leader>u', ':Telescope undo<CR>', desc = 'Undo tree' },
    --     },
    -- },
    { -- Project parser/watcher
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = require('nvim-treesitter.configs')

            configs.setup({
                ensure_installed = {
                    'gleam',
                    'html',
                    'javascript',
                    'lua',
                    'kdl',
                    'markdown',
                    'markdown_inline',
                    'jsonc',
                    'org',
                    'purescript',
                    'typescript',
                    'vim',
                    'vimdoc',
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                auto_install = true,
                ignore_install = {},
            })
        end,
    },
    { -- Case-intelligent search & replace.
        'tpope/vim-abolish',
    },
    { -- Bookmarking important files.
        'tomasky/bookmarks.nvim',
        event = 'VeryLazy',
        config = function()
            local telescope = require('telescope')
            telescope.load_extension('bookmarks')
            local bookmarks = require('bookmarks')
            bookmarks.setup({
                keywords = {
                    ['@t'] = '☑️ ', -- mark annotation startswith @t ,signs this icon as `Todo`
                    ['@w'] = '⚠️ ', -- mark annotation startswith @w ,signs this icon as `Warn`
                    ['@n'] = '📓', -- mark annotation startswith @n ,signs this icon as `Note`
                },
            })

            set_leader_mappings {
                { keys = 'ta', fn = bookmarks.bookmark_toggle, desc = 'Bookmark [A]dd/remove' },
                { keys = 'tc', fn = bookmarks.bookmark_ann, desc = 'Bookmark [C]lassify' },
                { keys = 'tl', fn = telescope.extensions.bookmarks.list, desc = 'Bookmark [L]ist' },
            }
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
    { -- dired+
        'elihunter173/dirbuf.nvim',
    },
    -- {
    --     'stevearc/oil.nvim',
    --     config = function()
    --         local oil = require('oil')
    --         oil.setup()
    --         vim.keymap.set('n', '-', oil.open, { desc = 'Open parent directory' })
    --     end,
    --     dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- },
    { -- Comment-out support
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup()
        end,
    },
    { -- Suggest keyboard shortcuts
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            local which = require('which-key')
            which.setup()
            which.register({
                ['<leader>g'] = { name = '[G]o to', _ = 'which_key_ignore' },
                ['<leader>k'] = { name = '[K]afka & doc[K]er', _ = 'which_key_ignore' },
                ['<leader>l'] = { name = '[L]azy', _ = 'which_key_ignore' },
                ['<leader>x'] = { name = 'e[X]ecutor', _ = 'which_key_ignore' },
                ['<leader>d'] = { name = '[D]ev', _ = 'which_key_ignore' },
                ['<leader>t'] = { name = '[T]ags & Bookmarks', _ = 'which_key_ignore' },
            })
        end,
    },
    {
        'https://github.com/smoka7/hop.nvim',
        config = function()
            require('hop').setup()
        end,
        keys = {
            { '<Leader>w', ':HopWord<CR>', desc = 'Hop to [W]ord' },
            { '<Leader>c', ':HopChar1<CR>', desc = 'Hop to Char' },
        },
    },

    'nvim-tree/nvim-web-devicons', -- Pretty fonticons.
    'MunifTanjim/nui.nvim',
    {
        'nvim-neo-tree/neo-tree.nvim', -- Filetree browser
        event = 'VeryLazy',
        config = function()
            require('neo-tree').setup()
            vim.keymap.set(
                'n',
                '<Leader>gt',
                ':Neotree toggle<CR>',
                { desc = 'File tree', noremap = true }
            )
        end,
    },

    { -- Magit
        'NeogitOrg/neogit',
        version = 'v0.0.1', -- Remove/update this when we udpate to Neovim 0.10.x.
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

    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        opts = {},
    },

    { -- Code formatters.
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                css = { 'prettier' },
                dhall = { 'dhall' },
                erlang = { 'erlfmt' },
                gleam = { 'gleam' },
                html = { 'prettier' },
                javascript = { 'prettier' },
                json = { 'jq' },
                lua = { 'stylua' },
                markdown = { 'prettier' },
                mojo = { 'mojofmt' },
                nix = { 'nixpkgs-fmt' },
                purescript = { 'purty' },
                python = { 'black' },
                rust = { 'rustfmt' },
                typescript = { 'prettier' },
                yaml = { 'yamlfmt' },
                zig = { 'zig' },
            },
            formatters = {
                purty = {
                    command = 'purty',
                    args = { '-' },
                },
                ['nixpkgs-fmt'] = {
                    command = 'nixpkgs-fmt',
                },
                jq = {
                    command = 'jq',
                    args = { '.' },
                },
                rustfmt = {
                    command = 'rustfmt',
                    args = {},
                },
                erlfmt = {
                    command = 'erlfmt',
                    args = { '-' },
                },
                gleam = {
                    command = 'gleam',
                    args = { 'format', '--stdin' },
                },
                yamlfmt = {
                    command = 'yamlfmt',
                    args = { '-' },
                },
                dhall = {
                    command = 'dhall',
                    args = { 'format' },
                },
                mojofmt = {
                    command = 'mojo',
                    args = { 'format', '-' },
                },
                zig = {
                    command = 'zig',
                    args = { 'fmt', '--stdin' },
                },
            },
        },
    },
    { -- Popular LSP configurations
        'neovim/nvim-lspconfig',

        config = function()
            -- See `:help lspconfig-all` for the list of available language servers.
            local lspconfig = require('lspconfig')
            vim.lsp.set_log_level('info')

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
            lspconfig.zls.setup({})
            lspconfig.gleam.setup({})

            -- NOTE: You may need to call `rustup component add rust-analyzer` for this to work.
            lspconfig.rust_analyzer.setup {
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false,
                        },
                    },
                },
            }

            lspconfig.pylsp.setup({})
            -- lspconfig.jedi_language_server.setup({
            --     init_options = {
            --         jedi_settings = {
            --             auto_import_modules = { 'quixstreams' },
            --         },
            --         jedi = {
            --             settings = {
            --                 auto_import_modules = { 'quixstreams' },
            --             },
            --         },
            --         settings = {
            --             auto_import_modules = { 'quixstreams' },
            --         },
            --         jediSettings = {
            --             autoImportModules = { 'quixstreams' },
            --         },
            --     },
            -- })
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

            lspconfig.tsserver.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show symbol info' })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
            vim.keymap.set({ 'n', 'v' }, '<C-c><C-k>', vim.lsp.buf.code_action)
            vim.keymap.set('n', 'Œ', function()
                require('conform').format()
            end, { desc = 'Reformat buffer' })
        end,
    },
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
                    { name = 'vsnip' },
                    { name = 'path' },
                }, {
                    { name = 'buffer' },
                }),
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')
            lspconfig['lua_ls'].setup({ capabilities = capabilities })
            lspconfig['pylsp'].setup({
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                enabled = false,
                                ignore = { 'W292', 'F401', 'W391', 'E302', 'F401' },
                            },
                            -- rope_autoimport = {
                            --     enabled = true,
                            --     memory = true,
                            -- },
                            -- rope_completion = { enabled = true },
                            -- jedi_definition = {
                            --     enabled = true,
                            -- },
                            -- jedi_completion = {
                            --     enabled = true,
                            --     include_function_objects = true,
                            --     include_class_objects = true,
                            --     fuzzy = true,
                            --     eager = true,
                            --     cache_for = { 'quixstreams' },
                            -- },
                            -- preload = {
                            --     enabled = true,
                            --     modules = { 'quixstreams' },
                            -- },
                            -- jedi = {
                            --     enabled = true,
                            --     auto_import_modules = { 'quixstreams' },
                            -- },
                            -- rope_completion = { enabled = true, eager = true },
                            -- jedi = {
                            --     enabled = true,
                            --     auto_import_modules = { 'quixstreams' },
                            -- },
                            flake8 = { enabled = false },
                            -- pyflakes = { enabled = true },
                            -- pylint = {
                            --     enabled = true,
                            -- },
                        },
                    },
                },
            })
        end,
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
        'folke/trouble.nvim', -- Error list.
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
        keys = {
            {
                '<leader>ge',
                '<cmd>Trouble diagnostics toggle focus=false<cr>',
                desc = 'Diagnostics (Trouble)',
            },
        },
    },
    { 'folke/neodev.nvim', opts = {} },
}
