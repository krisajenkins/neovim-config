return {
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',

        ---@module 'blink.cmp'
        ---@diagnostic disable-next-line: undefined-doc-name
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = 'default',
                -- Accept with Ctrl+Space (your preference)
                ['<Tab>'] = { 'accept', 'fallback' },
                -- Additional useful mappings
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            },

            completion = {
                -- Show docs on demand with Ctrl+Space twice, not automatically
                documentation = {
                    auto_show = true, -- Changed: auto-show is actually useful
                    auto_show_delay_ms = 500, -- Small delay to avoid flicker
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

            -- Appearance customization
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = 'mono',
            },

            -- Sources configuration
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                -- Customize per-source behavior
                providers = {
                    lsp = {
                        name = 'LSP',
                        enabled = true,
                        fallbacks = { 'buffer' }, -- Only show if LSP has no results
                    },
                    path = {
                        name = 'Path',
                        score_offset = -3, -- Lower priority than LSP
                    },
                    snippets = {
                        name = 'Snippets',
                        score_offset = -5, -- Even lower priority
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

            -- Signature help configuration
            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },
        },
        opts_extend = { 'sources.default' },
    },
}
