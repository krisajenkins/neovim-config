vim.api.nvim_create_user_command('SortMetrobankStatement', function()
    vim.cmd([[%!sort -t/ -n -k3 -k2 -k1]])
end, { desc = 'Sort Metrobank statement rows by date (DD/MM/YYYY)' })
