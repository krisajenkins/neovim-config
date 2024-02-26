local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("terrortylor/nvim-comment")

Plug("folke/which-key.nvim")
Plug("Lokaltog/vim-easymotion")

Plug("nvim-lua/plenary.nvim")
Plug("nvim-tree/nvim-web-devicons")
Plug("MunifTanjim/nui.nvim")
Plug("nvim-telescope/telescope.nvim", { tag = "0.1.5" })
Plug("nvim-neo-tree/neo-tree.nvim")

Plug("nvim-lua/plenary.nvim")
Plug("sindrets/diffview.nvim")
Plug("NeogitOrg/neogit")

Plug("nvim-treesitter/nvim-treesitter")
Plug("kylechui/nvim-surround")
Plug("mbbill/undotree")

Plug("tomasr/molokai")

Plug("purescript-contrib/purescript-vim")
Plug("neovim/nvim-lspconfig")
Plug("folke/trouble.nvim")

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
require("neogit").setup({})
require("nvim-surround").setup({})
require("nvim-treesitter.configs").setup({})
require('nvim_comment').setup()
require('which-key').setup()

-- More key mappings
local telescope_builtin = require('telescope.builtin')
vim.keymap.set("n", "<Leader>gs", ":Neogit<CR>", { desc = "Git status", noremap = true })
vim.keymap.set("n", "<Leader>ge", ":TroubleToggle<CR>", { desc = "Show errors", noremap = true })
vim.keymap.set("n", "<Leader>gf", telescope_builtin.find_files, { desc = "File finder", noremap = true })
vim.keymap.set("n", "<Leader>gg", telescope_builtin.live_grep, { desc = "Live grep", noremap = true })
vim.keymap.set("n", "<Leader>gb", telescope_builtin.buffers, { desc = "Buffer finder", noremap = true })
vim.keymap.set("n", "<Leader>gt", ":Neotree<CR>", { desc = "File tree", noremap = true })
vim.keymap.set("n", "<Leader>u", ":UndotreeToggle<CR>", { desc = "Undo tree", noremap = true })

-- LSP
-- See `:help lspconfig-all` for the list of available language servers.
local lspconfig = require("lspconfig")
vim.lsp.set_log_level('info')

local function reload_workspace(bufnr)
    bufnr = lspconfig.util.validate_bufnr(bufnr)
    local clients = vim.lsp.get_active_clients { name = 'rust_analyzer', bufnr = bufnr }
    for _, client in ipairs(clients) do
        vim.notify 'Reloading PureScript Workspace'
        client.request('load', nil, function(err)
            if err then
                error(tostring(err))
            end
            vim.notify 'PureScript workspace reloaded'
        end, 0)
    end
end

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lspconfig.purescriptls.setup({
    root_dir = lspconfig.util.root_pattern("spago.dhall", "spago.yaml"),
    commands = {
        PureScriptReload = {
            function()
                reload_workspace(0)
            end,
            description = 'Reload current PureScript workspace',
        },
    },
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
