-- Shared, single-instance toggleterm terminals for Haskell development.
-- Defined at module scope so require()'s cache keeps them unique even when
-- ftplugin/haskell.lua re-runs for every buffer.

local Terminal = require('toggleterm.terminal').Terminal

local M = {}

M.ghcid = Terminal:new({
    cmd = 'ghcid',
    count = 10,
    display_name = ' ghcid ',
    direction = 'horizontal',
    size = function()
        return math.floor(vim.o.lines * 0.2)
    end,
    close_on_exit = false,
    hidden = true,
    auto_scroll = true,
    on_open = function()
        vim.cmd('wincmd p')
    end,
})

M.test = Terminal:new({
    cmd = 'cabal test --test-show-details=direct',
    count = 11,
    display_name = ' cabal test ',
    direction = 'horizontal',
    size = function()
        return math.floor(vim.o.lines * 0.2)
    end,
    close_on_exit = false,
    hidden = true,
})

return M
