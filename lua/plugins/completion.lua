require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<Tab>'] = { 'accept', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
        menu = {
            draw = {
                columns = {
                    { 'label', 'label_description', gap = 1 },
                    { 'kind_icon', 'kind' },
                },
            },
        },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lsp = {
                name = 'LSP',
                enabled = true,
                fallbacks = { 'buffer' },
            },
            path = {
                name = 'Path',
                score_offset = -3,
            },
            snippets = {
                name = 'Snippets',
                score_offset = -5,
                opts = {
                    friendly_snippets = true,
                    search_paths = { vim.fn.stdpath('config') .. '/snippets' },
                },
            },
            buffer = {
                name = 'Buffer',
            },
        },
    },

    signature = {
        enabled = true,
        window = { border = 'rounded' },
    },
})
