local hl_store = {
  NeogitDiffAdd = { link = 'DiffAdd' },
  NeogitDiffChange = { link = 'DiffChange' },
  NeogitDiffDelete = { link = 'DiffDelete' },
  NeogitDiffText = { link = 'DiffText' },
}

for group, hl in pairs(hl_store) do
  vim.api.nvim_set_hl(0, group, hl)
end
