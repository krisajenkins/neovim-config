return {
    { -- Project parser/watcher
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function(plugin)
            require('nvim-treesitter.configs').setup({
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
                    'sql',
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

    { -- Purescript Support
        'purescript-contrib/purescript-vim',
        ft = { 'purescript' },
    },

    { 'ckipp01/stylua-nvim', ft = { 'lua' } },

    { 'bakudankun/pico-8.vim', ft = { 'pico8' } },

    { -- Render markdown in-buffer (opt-in via <Leader>rm)
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            enabled = false, -- Don't auto-enable; toggle with :RenderMarkdown toggle
            render_modes = { 'n', 'c' }, -- Only render in normal/command mode, not insert
        },
        keys = {
            {
                '<Leader>rm',
                function()
                    local rm = require('render-markdown')
                    rm.toggle()
                    -- Adjust conceallevel when toggling
                    local state = require('render-markdown.state')
                    if state.enabled then
                        vim.opt_local.conceallevel = 2
                    else
                        vim.opt_local.conceallevel = 0
                    end
                end,
                ft = 'markdown',
                desc = '[R]ender [M]arkdown toggle',
            },
        },
    },

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
