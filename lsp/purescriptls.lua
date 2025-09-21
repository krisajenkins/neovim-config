return {
    cmd = { 'purescript-language-server', '--stdio' },
    filetypes = { 'purescript' },
    root_markers = { 'spago.dhall', 'spago.yaml', 'bower.json', 'psc-package.json' },
    settings = {
        purescript = {
            addSpagoSources = true,
            formatter = 'purty',
        },
    },
}