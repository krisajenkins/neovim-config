-- Telescope
local utils = require('utils')
local set_leader_mappings = utils.set_leader_mappings
local telescope = require('telescope')
telescope.setup({
    defaults = {
        path_display = { 'smart' },
        wrap_results = true,
        prompt_prefix = '🔍 ',
        layout_config = {
            horizontal = {
                preview_width = 0.5,
            },
        },
        tiebreak = function(current_entry, existing_entry)
            return (current_entry[1]:lower() < existing_entry[1]:lower())
        end,
    },
})

local builtin = require('telescope.builtin')

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

set_leader_mappings({
    { keys = 'gf', fn = builtin.find_files, desc = '[F]ile finder' },
    { keys = 'gg', fn = builtin.live_grep, desc = 'Live [G]rep' },
    { keys = 'gb', fn = builtin.buffers, desc = '[B]uffer finder' },
    { keys = 'gk', fn = builtin.keymaps, desc = '[B]uffer finder' },
    { keys = 'ga', fn = builtin.resume, desc = 'Go [A]gain (resume previous search)' },
    { keys = 'go', fn = builtin.oldfiles, desc = '[O]ld files' },
    { keys = 'gh', fn = builtin.help_tags, desc = '[H]elp (manual)' },
    { keys = 'gi', fn = ':edit ~/.config/nvim/init.lua<CR>', desc = '[I]nit.lua' },
    {
        keys = 'gp',
        fn = ':edit ~/.config/nvim/lua/plugins/<CR>',
        desc = '[P]lugins directory',
    },
    {
        keys = 'gv',
        fn = function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = 'n[V]im config',
    },
    {
        keys = 'ds',
        fn = builtin.lsp_document_symbols,
        desc = '[D]ev document [S]ymbols',
    },
    { keys = 'dd', fn = builtin.lsp_definitions, desc = '[D]ev [D]efinitions' },
})

vim.keymap.set('n', '<Leader>s', function()
    local themes = require('telescope.themes')
    builtin.current_buffer_fuzzy_find(themes.get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = '[/] Fuzzily search in current buffer' })

-- Dirbuf
vim.keymap.set('n', '-', '<Plug>(dirbuf_up)', { desc = 'Open parent directory' })

-- Aerial
require('aerial').setup({})
vim.keymap.set('n', '<Leader>gm', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' })
vim.keymap.set('n', '<Leader>gn', '<cmd>AerialNavToggle<CR>', { desc = 'Toggle Aerial Nav' })
