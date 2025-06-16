local set_leader_mappings = require('utils').set_leader_mappings

return {
    -- Themes
    { 'tomasr/molokai' },
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
                modules = {},
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
                    'toml',
                    'unison',
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
            which.add({
                { '<leader>g', group = '[G]o to' },
                { '<leader>k', group = '[K]afka & doc[K]er' },
                { '<leader>l', group = '[L]azy' },
                { '<leader>x', group = 'e[X]ecutor' },
                { '<leader>d', group = '[D]ev' },
                { '<leader>t', group = '[T]ags & Bookmarks' },
            })
            -- which.register({
            --     ['<leader>g'] = { name = '[G]o to', _ = 'which_key_ignore' },
            --     ['<leader>k'] = { name = '[K]afka & doc[K]er', _ = 'which_key_ignore' },
            --     ['<leader>l'] = { name = '[L]azy', _ = 'which_key_ignore' },
            --     ['<leader>x'] = { name = 'e[X]ecutor', _ = 'which_key_ignore' },
            --     ['<leader>d'] = { name = '[D]ev', _ = 'which_key_ignore' },
            --     ['<leader>t'] = { name = '[T]ags & Bookmarks', _ = 'which_key_ignore' },
            -- })
        end,
    },
    -- {
    --     'https://github.com/smoka7/hop.nvim',
    --     config = function()
    --         require('hop').setup()
    --     end,
    --     keys = {
    --         { '<Leader>w', ':HopWord<CR>', desc = 'Hop to [W]ord' },
    --         { '<Leader>c', ':HopChar1<CR>', desc = 'Hop to Char' },
    --     },
    -- },

    'nvim-tree/nvim-web-devicons', -- Pretty fonticons.
    'MunifTanjim/nui.nvim',
    -- {
    --     'nvim-neo-tree/neo-tree.nvim', -- Filetree browser
    --     event = 'VeryLazy',
    --     config = function()
    --         require('neo-tree').setup()
    --         vim.keymap.set(
    --             'n',
    --             '<Leader>gt',
    --             ':Neotree toggle<CR>',
    --             { desc = 'File tree', noremap = true }
    --         )
    --         require('neo-tree').setup({
    --             window = {
    --                 mappings = {
    --                     ['P'] = {
    --                         'toggle_preview',
    --                         config = { use_float = false, use_image_nvim = true },
    --                     },
    --                     ['l'] = 'focus_preview',
    --                     ['<C-b>'] = { 'scroll_preview', config = { direction = 10 } },
    --                     ['<C-f>'] = { 'scroll_preview', config = { direction = -10 } },
    --                 },
    --             },
    --         })
    --     end,
    -- },

    { -- Magit
        'NeogitOrg/neogit',
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

    { -- Code formatter.
        'stevearc/conform.nvim',
        config = function()
            local conform = require('conform')
            conform.setup({
                formatters_by_ft = {
                    c = { 'clang-format' },
                    css = { 'prettier' },
                    dhall = { 'dhall' },
                    erlang = { 'erlfmt' },
                    gleam = { 'gleam' },
                    elm = { 'elm_format' },
                    html = { 'prettier' },
                    javascript = { 'prettier' },
                    json = { 'jq' },
                    lua = { 'stylua' },
                    markdown = { 'mdformat' },
                    mojo = { 'mojofmt' },
                    kotlin = { 'ktfmt' },
                    kdl = { 'kdlfmt' },
                    nix = { 'nixpkgsfmt' },
                    purescript = { 'purs_tidy' },
                    python = { 'ruff_organize_imports', 'ruff_format' },
                    rescript = { 'rescript-format' },
                    rust = { 'rustfmt' },
                    typescript = { 'prettier' },
                    typescriptreact = { 'prettier' },
                    toml = { 'prettier' },
                    yaml = { 'yamlfmt' },
                    zig = { 'zig' },
                },
                formatters = {
                    purty = {
                        command = 'purty',
                        args = { '-' },
                    },
                    purs_tidy = {
                        command = 'purs-tidy',
                        args = { 'format' },
                    },
                    mdformat = {
                        command = 'mdformat',
                        args = { '-' },
                    },
                    nixpkgsfmt = {
                        command = 'nixpkgs-fmt',
                    },
                    jq = {
                        command = 'jq',
                        args = { '.' },
                    },
                    rustfmt = {
                        command = 'rustfmt',
                        args = { '--edition', '2021' },
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
            })

            vim.keymap.set('n', 'Œ', conform.format, { desc = 'Reformat buffer' })
        end,
    },
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
        config = function()
            local trouble = require('trouble')
            trouble.setup({
                focus = false,
                modes = {
                    diagnostics = {
                        auto_close = true,
                    },
                },
                -- win = {
                --     type = 'float',
                --     border = 'rounded',
                --     size = { width = 0.38, height = 0.234 }, -- This is all based around Phi.
                --     position = { -5, -5 },
                -- },
            })
        end,
        keys = {
            {
                '<Leader>ge',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
        },
    },
    { 'folke/neodev.nvim', opts = {} },
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
}
