local palette = require('palette').palette

-- Use
local hl_store = {
    NeogitDiffAdd = { ctermfg = palette.green },
    NeogitDiffChange = { ctermfg = palette.rose, ctermbg = palette.yellow },
    NeogitDiffDelete = { ctermfg = palette.red },
    NeogitDiffText = { ctermbg = palette.grey },
    NeogitGraphAuthor = { ctermfg = palette.orange },
    NeogitGraphGreen = { ctermfg = palette.green },
    NeogitGraphCyan = { ctermfg = palette.cyan },
    NeogitGraphBlue = { ctermfg = palette.cyan },
    NeogitGraphPurple = { ctermfg = palette.purple },
    NeogitGraphOrange = { ctermfg = palette.orange },
    NeogitTagName = { ctermfg = palette.yellow },
    NeogitHeadRegion = { ctermfg = palette.blue },
    NeogitBranch = { ctermfg = palette.blue },
    NeogitBranchHead = { ctermfg = palette.blue },
    NeogitRemote = { ctermfg = palette.green },
    NeogitObjectId = { ctermfg = palette.yellow },
    Comment = { ctermfg = palette.yellow },
}

for group, hl in pairs(hl_store) do
    vim.api.nvim_set_hl(0, group, hl)
end
