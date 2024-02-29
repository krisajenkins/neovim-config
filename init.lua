local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Evaluating

Plug("nvim-orgmode/orgmode")
-- Graduated
Plug("tpope/vim-abolish")
Plug("tomasky/bookmarks.nvim")      -- Bookmarking important files.

Plug("beauwilliams/statusline.lua") -- Statusline
Plug("lewis6991/gitsigns.nvim")     -- Git Status hints in the left of the buffer
Plug("elihunter173/dirbuf.nvim")    -- dired+
Plug("terrortylor/nvim-comment")    -- Comment-out support

Plug("folke/which-key.nvim")        -- Suggest keyboard shortcuts
Plug("Lokaltog/vim-easymotion")     -- Jump around

Plug("nvim-lua/plenary.nvim")
Plug("nvim-tree/nvim-web-devicons")                      -- Pretty fonticons.
Plug("MunifTanjim/nui.nvim")
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.5" }) -- Everything browser
Plug("nvim-neo-tree/neo-tree.nvim")                      -- Filetree browser

Plug("nvim-lua/plenary.nvim")                            -- Magit dep
Plug("sindrets/diffview.nvim")                           -- Magit dep
Plug("NeogitOrg/neogit")                                 -- Magit

Plug("nvim-treesitter/nvim-treesitter")                  -- Project parser/watcher
Plug("kylechui/nvim-surround")
Plug("mbbill/undotree")                                  -- Undo history

Plug("tomasr/molokai")                                   -- Theme
Plug("catppuccin/nvim", { as = "catppuccin" })           -- Theme

Plug("purescript-contrib/purescript-vim")                -- Purescript Support
Plug("neovim/nvim-lspconfig")                            -- Popular LSP configurations
Plug("folke/trouble.nvim")                               -- Error list.

Plug("j-hui/fidget.nvim")                                -- Bottom-right corner notifications

vim.call("plug#end")

vim.g.do_filetype_lua = 1

-- Colorscheme
vim.cmd("colorscheme molokai")

-- Key mappings
vim.keymap.set("i", "jk", "<esc>", { noremap = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Options
vim.o.diffopt = "iwhite,filler"
vim.o.wrap = true
vim.o.number = false
vim.o.ruler = true
vim.o.showbreak = "↪"
vim.o.linebreak = true
vim.o.tabstop = 4
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true

-- Plugins that need setup/configuration.

require('orgmode').setup({ })
require("neogit").setup({})
require("nvim-surround").setup({})
require('orgmode').setup()
require('orgmode').setup_ts_grammar()
require("nvim-treesitter.configs").setup({
     highlight = {
        enable = true,
      },
     ensure_installed = { 'org' },
})
require("nvim_comment").setup()
require("which-key").setup()
require("fidget").setup()
-- require("gitsigns").setup({
--     signs = {
--         add = { text = "+" },
--         change = { text = "│" },
--         delete = { text = "-" },
--         topdelete = { text = "‾" },
--         changedelete = { text = "~" },
--         untracked = { text = "?" },
--     },
-- })

local bookmarks = require('bookmarks')
bookmarks.setup({
    keywords = {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@n"] = "📓", -- mark annotation startswith @n ,signs this icon as `Note`
    },
})
require('telescope').load_extension('bookmarks')
vim.keymap.set("n", "<Leader>ta", bookmarks.bookmark_toggle, { desc = "Bookmark Toggle", noremap = true })
vim.keymap.set("n", "<Leader>tc", bookmarks.bookmark_ann, { desc = "Bookmark Classify", noremap = true })
vim.keymap.set("n", "<Leader>tl", ":Telescope bookmarks list<CR>", { desc = "Bookmark Browse", noremap = true })

-- More key mappings
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>gs", ":Neogit cwd=%:p:h<CR>", { desc = "Git status", noremap = true })
vim.keymap.set("n", "<Leader>ge", ":TroubleToggle<CR>", { desc = "Show errors", noremap = true })
vim.keymap.set("n", "<Leader>gf", telescope_builtin.find_files, { desc = "File finder", noremap = true })
vim.keymap.set("n", "<Leader>gg", telescope_builtin.live_grep, { desc = "Live grep", noremap = true })
vim.keymap.set("n", "<Leader>gb", telescope_builtin.buffers, { desc = "Buffer finder", noremap = true })
vim.keymap.set("n", "<Leader>gt", ":Neotree<CR>", { desc = "File tree", noremap = true })
vim.keymap.set("n", "<Leader>u", ":UndotreeToggle<CR>", { desc = "Undo tree", noremap = true })

-- LSP
-- See `:help lspconfig-all` for the list of available language servers.
local lspconfig = require("lspconfig")
vim.lsp.set_log_level("info")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lspconfig.purescriptls.setup({
    root_dir = lspconfig.util.root_pattern("spago.dhall", "spago.yaml"),
    settings = {
        purescript = {
            addSpagoSources = true,
            formatter = "purty",
        },
    },
})

lspconfig.tsserver.setup({})

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show symbol info" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set({ "n", "v" }, "<C-c><C-k>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references)
vim.keymap.set("n", "©p", vim.diagnostic.goto_prev)
vim.keymap.set("n", "©n", vim.diagnostic.goto_next)
vim.keymap.set("n", "Œ", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Reformat buffer" })

local palette = require("palette").palette
vim.api.nvim_set_hl(0, "Comment", { ctermfg = palette.yellow })
vim.api.nvim_set_hl(0, "purescriptModuleParams", { ctermfg = palette.cyan })
