local minitest = require('mini.test')
minitest.setup()

vim.keymap.set('n', '<Leader>dt', minitest.run, { desc = '[D]ev mini[T]est run' })
