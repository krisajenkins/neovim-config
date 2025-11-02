vim.api.nvim_create_user_command('Vecgrep', function(opts)
    local query = opts.args

    vim.notify('Vecgrep: searching for "' .. query .. '"...')

    vim.system(
        { 'vecgrep', '--json', '-q', query },
        { text = true },
        vim.schedule_wrap(function(result)
            if result.code ~= 0 then
                vim.notify('Vecgrep failed: ' .. (result.stderr or ''), vim.log.levels.ERROR)
                return
            end

            local items = {}
            for line in result.stdout:gmatch('[^\n]+') do
                local ok, entry = pcall(vim.json.decode, line)
                if ok and entry.file then
                    table.insert(items, {
                        filename = entry.file,
                        lnum = entry.start_line,
                        text = string.format('[%.2f] %s', entry.score, entry.text:gsub('\n', ' ')),
                    })
                end
            end

            if #items == 0 then
                vim.notify('Vecgrep: no results', vim.log.levels.WARN)
                return
            end

            vim.fn.setqflist({}, ' ', { title = 'Vecgrep: ' .. query, items = items })
            vim.cmd.copen()
        end)
    )
end, { nargs = '+', desc = 'Semantic grep via vecgrep' })
