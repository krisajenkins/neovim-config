-- Treesitter (new API - highlighting/indenting are built-in via vim.treesitter)
-- Just ensure parsers are installed
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local parsers = {
            'allium',
            'gleam',
            'html',
            'javascript',
            'lua',
            'kdl',
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
        }
        for _, lang in ipairs(parsers) do
            pcall(function()
                vim.treesitter.language.add(lang)
            end)
        end
    end,
})

-- Allium
local ok_allium, nvim_allium = pcall(require, 'nvim-allium')
if ok_allium then
    nvim_allium.setup({})
end

-- Render markdown (disabled by default, toggle with <Leader>rm)
require('render-markdown').setup({
    enabled = false,
    render_modes = { 'n', 'c' },
})

vim.keymap.set('n', '<Leader>rm', function()
    local rm = require('render-markdown')
    rm.toggle()
    local state = require('render-markdown.state')
    if state.enabled then
        vim.opt_local.conceallevel = 2
    else
        vim.opt_local.conceallevel = 0
    end
end, { desc = '[R]ender [M]arkdown toggle' })

-- Toit IDE tools
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'toit',
    callback = function()
        local ide_tools_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/ide-tools/start/vim'
        if vim.fn.isdirectory(ide_tools_path) == 1 then
            vim.opt.rtp:append(ide_tools_path)
        end
    end,
})
