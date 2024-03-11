------------------------------------------------------------
-- Core Key mappings
------------------------------------------------------------
vim.keymap.set('i', 'jk', '<esc>', { noremap = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.do_filetype_lua = 1

------------------------------------------------------------
-- Core Options
------------------------------------------------------------
vim.opt.diffopt = 'iwhite,filler'
vim.opt.signcolumn = 'yes'
vim.opt.wrap = true
vim.opt.number = false
vim.opt.ruler = true
vim.opt.showbreak = '↪'
vim.opt.linebreak = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.conceallevel = 2

vim.opt.breakindent = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
    --------------------------------------------------------------
    -- Evaluating
    --------------------------------------------------------------
    { 'akinsho/toggleterm.nvim', version = '*', config = true },
    { 'bakudankun/pico-8.vim' },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-y>'] = cmp.mapping.confirm { select = true },
                    ['<C-Space>'] = cmp.mapping.complete {},
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
            --require('lspconfig')['purescriptls'].setup { capabilities = capabilities }
        end,
    },
    {
        'epwalsh/obsidian.nvim',
        lazy = true,
        opts = {
            workspaces = { { name = 'Personal', path = "~/Documents/Kris Jenkins' Notes/" } },
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ 'open', url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,
        },
    },
    {
        'renerocksai/telekasten.nvim',
        lazy = true,
        config = function()
            local telekasten = require('telekasten')
            telekasten.setup({
                home = vim.fn.expand('~/telekasten'),
            })
            vim.keymap.set(
                'n',
                '<Leader>n',
                ':Telekasten panel<CR>',
                { desc = 'Telekasten panel', noremap = true }
            )
        end,
    },
    {
        -- Org Mode
        -- Useful shortcuts: https://nvim-orgmode.github.io/features.html
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter' },
        },
        ft = 'org',
        lazy = true,
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
        --cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },
    {
        'krisajenkins/telescope-docker.nvim',
        dev = true,
        event = 'VeryLazy',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension('telescope_docker')
            require('telescope_docker').setup {}
            vim.keymap.set(
                'n',
                '<Leader>kv',
                ':Telescope telescope_docker docker_volumes<CR>',
                { desc = 'doc[K]er [V]olumes' }
            )
            vim.keymap.set(
                'n',
                '<Leader>ki',
                ':Telescope telescope_docker docker_images<CR>',
                { desc = 'doc[K]er [I]mages' }
            )
        end,
    },
    {
        'krisajenkins/telescope-kafka.nvim',
        dev = true,
        event = 'VeryLazy',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension('telescope_kafka')
            require('telescope_kafka').setup({
                kcat_path = '/nix/store/f5mjzhssy0p164azn8vk4vqh1yi4xazq-kcat/bin/kcat',
            })
            vim.keymap.set(
                'n',
                '<Leader>kt',
                ':Telescope telescope_kafka kafka_topics<CR>',
                { desc = '[K]afka [T]opics' }
            )
        end,
    },
    --------------------------------------------------------------
    -- Graduated
    --------------------------------------------------------------
    { -- Everything browser
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')
            local themes = require('telescope.themes')

            pcall(telescope.load_extension, 'fzf')
            pcall(telescope.load_extension, 'ui-select')

            vim.keymap.set('n', '<Leader>gf', builtin.find_files, { desc = '[F]ile finder' })
            vim.keymap.set('n', '<Leader>gg', builtin.live_grep, { desc = 'Live [G]rep' })
            vim.keymap.set('n', '<Leader>gb', builtin.buffers, { desc = '[B]uffer finder' })
            vim.keymap.set('n', '<Leader>gk', builtin.keymaps, { desc = '[B]uffer finder' })
            vim.keymap.set(
                'n',
                '<Leader>ga',
                builtin.resume,
                { desc = 'Go [A]gain (resume previous search)' }
            )
            vim.keymap.set('n', '<Leader>go', builtin.oldfiles, { desc = '[O]ld files' })
            vim.keymap.set('n', '<Leader>gh', builtin.help_tags, { desc = '[M]anual' })
            vim.keymap.set('n', '<Leader>gv', function()
                builtin.find_files({ cwd = vim.fn.stdpath 'config' })
            end, { desc = 'n[V]im config' })
            vim.keymap.set(
                'n',
                '<leader>ds',
                builtin.lsp_document_symbols,
                { desc = 'LSP [D]ocument [S]ymbols' }
            )
            vim.keymap.set('n', '<leader>s', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                builtin.current_buffer_fuzzy_find(themes.get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = '[/] Fuzzily search in current buffer' })
        end,
    },
    { -- Undo tree.
        'debugloop/telescope-undo.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension('undo')
            vim.keymap.set(
                'n',
                '<Leader>u',
                ':Telescope undo<CR>',
                { desc = 'Undo tree', noremap = true }
            )
        end,
    },
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
                    'markdown',
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
    {
        'gleam-lang/gleam.vim',
        config = function() end,
    },

    { -- Statusline
        'freddiehaddad/feline.nvim',
        event = 'VeryLazy',
        config = function()
            local feline = require('feline')
            feline.setup()
            feline.winbar.setup()
        end,
    },
    'tpope/vim-abolish',
    { -- Bookmarking important files.
        'tomasky/bookmarks.nvim',
        event = 'VeryLazy',
        config = function()
            require('telescope').load_extension('bookmarks')
            local bookmarks = require('bookmarks')
            bookmarks.setup({
                keywords = {
                    ['@t'] = '☑️ ', -- mark annotation startswith @t ,signs this icon as `Todo`
                    ['@w'] = '⚠️ ', -- mark annotation startswith @w ,signs this icon as `Warn`
                    ['@n'] = '📓', -- mark annotation startswith @n ,signs this icon as `Note`
                },
            })

            vim.keymap.set(
                'n',
                '<Leader>ta',
                bookmarks.bookmark_toggle,
                { desc = 'Bookmark [A]dd/remove', noremap = true }
            )
            vim.keymap.set(
                'n',
                '<Leader>tc',
                bookmarks.bookmark_ann,
                { desc = 'Bookmark [C]lassify', noremap = true }
            )
            vim.keymap.set(
                'n',
                '<Leader>tl',
                ':Telescope bookmarks list<CR>',
                { desc = 'Bookmark [L]ist', noremap = true }
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
    { -- dired+
        'elihunter173/dirbuf.nvim',
    },
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
                ['<leader>t'] = { name = '[T]ags & Bookmarks', _ = 'which_key_ignore' },
            })
        end,
    },
    'Lokaltog/vim-easymotion', -- Jump around

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
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        },
        lazy = true,
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
    'tomasr/molokai', -- Theme

    { -- Purescript Support
        'purescript-contrib/purescript-vim',
    },
    { 'ckipp01/stylua-nvim' },
    { -- Code formatters.
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup {
                formatters_by_ft = {
                    lua = { 'stylua' },
                    python = { 'black' },
                    javascript = { 'prettier' },
                    typescript = { 'prettier' },
                    purescript = { 'purty' },
                    nix = { 'nixpkgs-fmt' },
                    dhall = { 'dhall' },
                },
                formatters = {
                    purty = {
                        command = 'purty',
                        args = { '-' },
                    },
                    ['nixpkgs-fmt'] = {
                        command = 'nixpkgs-fmt',
                    },
                    dhall = {
                        command = 'dhall',
                        args = { 'format' },
                    },
                },
            }
        end,
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
            lspconfig.gleam.setup({})
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
            vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.references)
            vim.keymap.set('n', 'Œ', function()
                require('conform').format()
            end, { desc = 'Reformat buffer' })
        end,
    },
    {
        'folke/trouble.nvim', -- Error list.
        config = function()
            vim.keymap.set(
                'n',
                '<Leader>ge',
                ':TroubleToggle<CR>',
                { desc = '[E]rrors', noremap = true }
            )
        end,
    },
    { -- Bottom-right corner notifications
        'j-hui/fidget.nvim',
        opts = {},
    },
    { 'folke/neodev.nvim', opts = {} },
}, {
    dev = {
        path = '/Users/krisjenkins/.config/nvim/dev/',
    },
})

-- Colorscheme
vim.cmd('colorscheme molokai')

-- Diagnostics.
vim.keymap.set('n', '©p', vim.diagnostic.goto_prev)
vim.keymap.set('n', '©n', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>lp', ':Lazy profile<CR>', { desc = '[L]azy [P]rofile' })

-- Syntax highlighting customisation.
vim.api.nvim_set_hl(0, 'Comment', { link = 'String' })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set('n', '<leader>t', ':edit term://zsh<CR>', { desc = 'Open a Terminal' })

vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end
    end,
})
