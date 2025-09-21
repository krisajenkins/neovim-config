return {
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
                    haskell = { 'ormolu' },
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
                    toml = { 'taplo' },
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

    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        opts = {},
    },

    { -- Comment-out support
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup()
        end,
    },

    { -- Case-intelligent search & replace.
        'tpope/vim-abolish',
    },

    {
        'Wansmer/treesj',
        event = 'VeryLazy',
        opts = {},
    },

    {
        'dawsers/edit-code-block.nvim',
        event = 'VeryLazy',
        opts = {},
    },
}
