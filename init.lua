------------------------------------------------------------
-- Core Key mappings
------------------------------------------------------------
vim.keymap.set("i", "jk", "<esc>", { noremap = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","

------------------------------------------------------------
-- Core Options
------------------------------------------------------------
vim.g.do_filetype_lua = 1
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
vim.o.termguicolors = true
vim.opt.mouse = "a"
vim.opt.conceallevel = 2

------------------------------------------------------------
-- Plugins
------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	--------------------------------------------------------------
	-- Evaluating
	--------------------------------------------------------------
	{
		"epwalsh/obsidian.nvim",
		config = function()
			require("obsidian").setup({
				workspaces = { { name = "Personal", path = "~/Documents/Kris Jenkins' Notes/" } },
				follow_url_func = function(url)
					-- Open the URL in the default web browser.
					vim.fn.jobstart({ "open", url }) -- Mac OS
					-- vim.fn.jobstart({"xdg-open", url})  -- linux
				end,
			})
		end,
	},
	{
		"renerocksai/telekasten.nvim",
		config = function()
			local telekasten = require("telekasten")
			telekasten.setup({
				home = vim.fn.expand("~/telekasten"),
			})
			vim.keymap.set("n", "<Leader>n", ":Telekasten panel<CR>", { desc = "Telekasten panel", noremap = true })
		end,
	},
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", lazy = true },
		},
		ft = "org",
		config = function()
			-- Load treesitter grammar for org
			local orgmode = require("orgmode")
			-- Setup orgmode
			orgmode.setup({
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/refile.org",
			})
			orgmode.setup_ts_grammar()
		end,
	},
	--------------------------------------------------------------
	-- Graduated
	--------------------------------------------------------------
	{ -- Everything browser
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({})
		end,
	},
	{ -- Undo tree.
		"debugloop/telescope-undo.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("undo")
		end,
	},
	{ -- Project parser/watcher
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"purescript",
					"javascript",
					"html",
					"org",
					"typescript",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	{ -- Statusline
		"freddiehaddad/feline.nvim",
		event = "VeryLazy",
		config = function()
			local feline = require("feline")
			feline.setup()
			feline.winbar.setup()
		end,
	},
	"tpope/vim-abolish",
	{ -- Bookmarking important files.
		"tomasky/bookmarks.nvim",
		config = function()
			local bookmarks = require("bookmarks")
			bookmarks.setup({
				keywords = {
					["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
					["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
					["@n"] = "📓", -- mark annotation startswith @n ,signs this icon as `Note`
				},
			})
		end,
	},
	{ -- Git Status hints in the left of the buffer
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "│" },
					delete = { text = "-" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "?" },
				},
			})
		end,
	},
	{ -- dired+
		"elihunter173/dirbuf.nvim",
	},
	{ -- Comment-out support
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},
	{ -- Suggest keyboard shortcuts
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},
	"Lokaltog/vim-easymotion", -- Jump around

	"nvim-tree/nvim-web-devicons", -- Pretty fonticons.
	"MunifTanjim/nui.nvim",
	"nvim-neo-tree/neo-tree.nvim", -- Filetree browser

	"nvim-lua/plenary.nvim", -- Magit dep
	"sindrets/diffview.nvim", -- Magit dep
	{ -- Magit
		"NeogitOrg/neogit",
		event = "VimEnter",
		config = function()
			require("neogit").setup()
			vim.keymap.set("n", "<Leader>gs", ":Neogit cwd=%:p:h<CR>", { desc = "[G]it [S]tatus", noremap = true })
		end,
	},

	"kylechui/nvim-surround",
	"tomasr/molokai", -- Theme

	"purescript-contrib/purescript-vim", -- Purescript Support
	{
		-- Popular LSP configurations
		"neovim/nvim-lspconfig",

		config = function()
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

			lspconfig.hls.setup({})
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
			vim.keymap.set("n", "Œ", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Reformat buffer" })
		end,
	},
	"folke/trouble.nvim", -- Error list.
	{ -- Bottom-right corner notifications
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
})

-- Colorscheme
vim.cmd("colorscheme molokai")

-- Plugins that need additional setup/configuration.
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<Leader>gf", telescope_builtin.find_files, { desc = "File finder" })
vim.keymap.set("n", "<Leader>gg", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<Leader>gb", telescope_builtin.buffers, { desc = "Buffer finder" })

require("telescope").load_extension("bookmarks")
local bookmarks = require("bookmarks")
vim.keymap.set("n", "<Leader>ta", bookmarks.bookmark_toggle, { desc = "Bookmark Toggle", noremap = true })
vim.keymap.set("n", "<Leader>tc", bookmarks.bookmark_ann, { desc = "Bookmark Classify", noremap = true })
vim.keymap.set("n", "<Leader>tl", ":Telescope bookmarks list<CR>", { desc = "Bookmark Browse", noremap = true })

vim.keymap.set("n", "<Leader>ge", ":TroubleToggle<CR>", { desc = "Show errors", noremap = true })
vim.keymap.set("n", "<Leader>gt", ":Neotree toggle<CR>", { desc = "File tree", noremap = true })
vim.keymap.set("n", "<Leader>u", ":Telescope undo<CR>", { desc = "Undo tree", noremap = true })

-- Diagnostics.
vim.keymap.set("n", "©p", vim.diagnostic.goto_prev)
vim.keymap.set("n", "©n", vim.diagnostic.goto_next)

-- Syntax highlighting customisation.
vim.api.nvim_set_hl(0, "Comment", { link = "String"})
