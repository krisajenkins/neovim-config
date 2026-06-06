vim.opt_local.makeprg = 'cabal build'
vim.opt_local.commentstring = '-- %s'

local hs = require('haskell')

vim.keymap.set({ 'n', 't' }, '<Leader>dg', function()
    hs.ghcid:toggle()
end, { desc = '[D]ev [G]hcid toggle' })

vim.keymap.set({ 'n', 't' }, '<Leader>dt', function()
    hs.test:toggle()
end, { desc = '[D]ev cabal [T]est' })
