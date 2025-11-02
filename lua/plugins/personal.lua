return {
    {
        'krisajenkins/oversight-nvim',
        dev = true,
        config = function()
            local oversight = require('oversight')
            oversight.setup()
        end,
    },
    {
        'krisajenkins/NeoJJ',
        dev = true,
        config = function()
            local neojj = require('neojj')
            neojj.setup()

            local utils = require('utils')
            local set_leader_mappings = utils.set_leader_mappings
            set_leader_mappings {
                { keys = 'js', fn = neojj.jj_status, desc = 'JJ Status' },
                { keys = 'jl', fn = neojj.jj_log, desc = 'JJ Log' },
                { keys = 'ja', fn = neojj.jj_annotate, desc = 'JJ Log' },
            }
        end,
    },

    -- {
    --     'krisajenkins/telescope-quix.nvim',
    --     dev = true,
    --     event = 'VeryLazy',
    --     dependencies = {
    --         'nvim-telescope/telescope.nvim',
    --         'folke/which-key.nvim',
    --     },
    --     config = function()
    --         require('telescope').load_extension('telescope_quix')
    --         require('telescope_quix').setup {}
    --         local which = require('which-key')
    --         which.add({
    --             { '<leader>q', group = '[Q]uix' },
    --         })
    --     end,
    --     keys = {
    --         {
    --             '<Leader>qa',
    --             ':Telescope telescope_quix quix_applications<CR>',
    --             desc = '[Q]uix [A]pplications',
    --         },
    --         {
    --             '<Leader>qd',
    --             ':Telescope telescope_quix quix_deployments<CR>',
    --             desc = '[Q]uix [D]eployments',
    --         },
    --         {
    --             '<Leader>qe',
    --             ':Telescope telescope_quix quix_environments<CR>',
    --             desc = '[Q]uix [E]nvironments',
    --         },
    --         {
    --             '<Leader>ql',
    --             ':Telescope telescope_quix quix_library<CR>',
    --             desc = '[Q]uix [L]ibrary',
    --         },
    --         {
    --             '<Leader>qo',
    --             ':Telescope telescope_quix quix_organisations<CR>',
    --             desc = '[Q]uix [O]rganisations',
    --         },
    --         {
    --             '<Leader>qp',
    --             ':Telescope telescope_quix quix_projects<CR>',
    --             desc = '[Q]uix [P]rojects',
    --         },
    --         {
    --             '<Leader>qt',
    --             ':Telescope telescope_quix quix_topics<CR>',
    --             desc = '[Q]uix [T]opics',
    --         },
    --         {
    --             '<Leader>qr',
    --             ':Telescope telescope_quix quix_repositories<CR>',
    --             desc = '[Q]uix [R]epositories',
    --         },
    --         {
    --             '<Leader>qw',
    --             ':Telescope telescope_quix quix_workspaces<CR>',
    --             desc = '[Q]uix [W]orkspaces',
    --         },
    --     },
    -- },
    -- {
    --     'krisajenkins/snow.nvim',
    --     dev = true,
    --     dependencies = {
    --         'nvim-lua/plenary.nvim', -- if needed
    --         'MunifTanjim/nui.nvim', -- if needed
    --     },
    --     event = 'VeryLazy',
    --     config = function()
    --         require('snow').setup {
    --             -- Configuration options
    --         }
    --     end,
    -- },

    --     {
    --         'krisajenkins/telescope-docker.nvim',
    --         dev = true,
    --         event = 'VeryLazy',
    --         dependencies = {
    --             'nvim-telescope/telescope.nvim',
    --         },
    --         config = function()
    --             require('telescope').load_extension('telescope_docker')
    --             require('telescope_docker').setup {}
    --         end,
    --         keys = {
    --             {
    --                 '<Leader>kv',
    --                 ':Telescope telescope_docker docker_volumes<CR>',
    --                 desc = 'doc[K]er [V]olumes',
    --             },
    --             {
    --                 '<Leader>kp',
    --                 ':Telescope telescope_docker docker_ps<CR>',
    --                 desc = 'doc[K]er [P]rocesses',
    --             },
    --             {
    --                 '<Leader>ki',
    --                 ':Telescope telescope_docker docker_images<CR>',
    --                 desc = 'doc[K]er [I]mages',
    --             },
    --         },
    --     },
    --
    --     {
    --         'krisajenkins/telescope-kafka.nvim',
    --         dev = true,
    --         event = 'VeryLazy',
    --         dependencies = {
    --             'nvim-telescope/telescope.nvim',
    --         },
    --         config = function()
    --             require('telescope').load_extension('telescope_kafka')
    --             require('telescope_kafka').setup({
    --                 kcat_path = '/nix/store/f5mjzhssy0p164azn8vk4vqh1yi4xazq-kcat/bin/kcat',
    --             })
    --         end,
    --         keys = {
    --             '<Leader>kt',
    --             ':Telescope telescope_kafka kafka_topics<CR>',
    --             desc = '[K]afka [T]opics',
    --         },
    --     },
}
