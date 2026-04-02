-- Enable treesitter highlighting for any buffer that has a parser available
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})

-- Treesitter parser installation (deferred to avoid slowing startup)
local parsers = {
    'gleam',
    'html',
    'javascript',
    'lua',
    'kdl',
    'markdown_inline',
    'sql',
    'toml',
    'unison',
    'purescript',
    'typescript',
    'vim',
    'vimdoc',
}

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        local install = require('nvim-treesitter.install')
        for _, lang in ipairs(parsers) do
            -- install() is a no-op if the parser is already present and up to date
            install.install(lang)
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
