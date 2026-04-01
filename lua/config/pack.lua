-- Plugin management via vim.pack (Neovim 0.12+)

-- Dev plugins via runtimepath
vim.opt.rtp:prepend('/Users/krisjenkins/Work/ThirdParty/neogit')
vim.opt.rtp:prepend(vim.fn.expand('~/Work/Tools/nvim/oversight-nvim'))
vim.opt.rtp:prepend(vim.fn.expand('~/Work/Tools/nvim/neojj'))
vim.opt.rtp:prepend(vim.fn.expand('~/Work/Tools/canon-languages/nvim'))

-- All remote plugins
local plugins = {
    'https://github.com/tomasr/molokai',
    'https://github.com/saghen/blink.cmp',
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/kylechui/nvim-surround',
    'https://github.com/tpope/vim-abolish',
    'https://github.com/Wansmer/treesj',
    'https://github.com/dawsers/edit-code-block.nvim',
    'https://github.com/echasnovski/mini.nvim',
    'https://github.com/folke/trouble.nvim',
    'https://github.com/kevinhwang91/nvim-ufo',
    'https://github.com/kevinhwang91/promise-async',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/juxt/nvim-allium',
    'https://github.com/purescript-contrib/purescript-vim',
    'https://github.com/ckipp01/stylua-nvim',
    'https://github.com/bakudankun/pico-8.vim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/toitware/ide-tools',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    'https://github.com/elihunter173/dirbuf.nvim',
    'https://github.com/stevearc/aerial.nvim',
    'https://github.com/akinsho/toggleterm.nvim',
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/sindrets/diffview.nvim',
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    'https://github.com/tpope/vim-dadbod',
    'https://github.com/google/executor.nvim',
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/iamcco/markdown-preview.nvim',
    'https://github.com/tigion/nvim-asciidoc-preview',
    'https://github.com/bngarren/checkmate.nvim',
    'https://github.com/hat0uma/csvview.nvim',
}

-- Install any missing plugins
vim.pack.add(plugins)

-- Add all opt plugins to runtimepath and Lua search paths
local opt_dir = vim.fn.stdpath('data') .. '/site/pack/core/opt'
for _, url in ipairs(plugins) do
    local name = url:match('.*/(.+)$')
    local plugin_path = opt_dir .. '/' .. name
    if vim.fn.isdirectory(plugin_path) == 1 then
        vim.opt.rtp:prepend(plugin_path)
        -- Add to Lua package.path so require() works
        local lua_dir = plugin_path .. '/lua'
        if vim.fn.isdirectory(lua_dir) == 1 then
            package.path = lua_dir .. '/?.lua;' .. lua_dir .. '/?/init.lua;' .. package.path
        end
    end
end

-- Load all plugin configs
require('plugins.completion')
require('plugins.editing')
require('plugins.interface')
require('plugins.languages')
require('plugins.navigation')
require('plugins.terminals')
require('plugins.tools')
require('plugins.personal')
