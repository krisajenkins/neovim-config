 -----------------------------------------------------------
-- Any language-specific plugins.
------------------------------------------------------------
return {
    {
        'gleam-lang/gleam.vim',
        ft = { 'gleam' },
        config = function() end,
    },
    { -- Purescript Support
        'purescript-contrib/purescript-vim',
        ft = { 'purescript' },
    },
    { 'ckipp01/stylua-nvim', ft = { 'lua' } },
    { 'bakudankun/pico-8.vim', ft = { 'pico8' } },
}
