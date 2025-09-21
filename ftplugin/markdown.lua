local hl_store = {}

hl_store['@markup.heading.1.markdown'] = { link = 'Identifier' }
hl_store['@markup.heading.2.markdown'] = { link = 'Function' }
hl_store['@markup.strong.markdown_inline'] = { link = 'Keyword' }
hl_store['@markup.italic.markdown_inline'] = { link = 'Keyword' }
hl_store['htmlComment'] = { link = 'Comment' }

for group, hl in pairs(hl_store) do
    vim.api.nvim_set_hl(0, group, hl)
end

vim.cmd('setlocal spell spelllang=en_gb')
