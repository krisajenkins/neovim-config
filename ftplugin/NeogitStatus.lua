local hl_store = {
    NeogitDiffAdd = { ctermfg = 118 },
    NeogitDiffChange = { ctermfg = 181, ctermbg = 230 },
    NeogitDiffDelete = { ctermfg = 161 },
    NeogitDiffText = { ctermbg = 102 }
}

for group, hl in pairs(hl_store) do
    vim.api.nvim_set_hl(0, group, hl)
end
