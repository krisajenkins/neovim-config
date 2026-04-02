-- Copy current buffer's full path to clipboard
vim.api.nvim_create_user_command('CopyFilename', function()
    vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy buffer filename to the clipboard' })
