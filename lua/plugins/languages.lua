return {
    { -- Project parser/watcher
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
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
        },
    },
    {
        'gleam-lang/gleam.vim',
        ft = { 'gleam' },
        opts = {},
    },

    { -- Purescript Support
        'purescript-contrib/purescript-vim',
        ft = { 'purescript' },
    },

    { 'ckipp01/stylua-nvim', ft = { 'lua' } },

    { 'bakudankun/pico-8.vim', ft = { 'pico8' } },

    {
        'toitware/ide-tools',
        ft = { 'toit' },
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. '/start/vim')
        end,
        init = function(plugin)
            require('lazy.core.loader').ftdetect(plugin.dir .. '/start/vim')
        end,
    },
}

