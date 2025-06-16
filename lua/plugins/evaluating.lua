-- highlight CursorH guibg=lightgreen
-- set guicursor=n-v-c-i:block-CursorH
-- let g:neovide_cursor_trail_size=0
-- let g:neovide_cursor_animation_length=0.3
------------------------------------------------------------
-- This is a staging area. Plugins that have yet to prove themselves essential.
------------------------------------------------------------

-- local OLLAMA_MODEL = 'deepseek-coder-v2'
local OLLAMA_MODEL = 'qwen2.5-coder:32b'

return {
    {
        -- Nice formatting for TODO.md files.
        'bngarren/checkmate.nvim',
        ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
        opts = {
            -- your configuration here
            -- or leave empty to use defaults
        },
    },
    {
        'greggh/claude-code.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim', -- Required for git operations
        },
        config = function()
            require('claude-code').setup({
                window = {
                    split_ratio = 0.8,
                    position = 'vsplit',
                },
            })
        end,
    },
    -- {
    --     'frankroeder/parrot.nvim',
    --     dependencies = { 'ibhagwan/fzf-lua', 'nvim-lua/plenary.nvim' },
    --     -- optionally include "folke/noice.nvim" or "rcarriga/nvim-notify" for beautiful notifications
    --     config = function()
    --         require('parrot').setup {
    --             -- Providers must be explicitly set up to make them available.
    --             providers = {
    --                 ollama = {
    --                     name = 'ollama',
    --                     endpoint = 'http://localhost:11434/api/chat',
    --                     api_key = '', -- not required for local Ollama
    --                     params = {
    --                         chat = { temperature = 1.5, top_p = 1, num_ctx = 8192, min_p = 0.05 },
    --                         command = { temperature = 1.5, top_p = 1, num_ctx = 8192, min_p = 0.05 },
    --                     },
    --                     topic_prompt = [[
    -- Summarize the chat above and only provide a short headline of 2 to 3
    -- words without any opening phrase like "Sure, here is the summary",
    -- "Sure! Here's a shortheadline summarizing the chat" or anything similar.
    -- ]],
    --                     topic = {
    --                         model = 'llama3.2',
    --                         params = { max_tokens = 32 },
    --                     },
    --                     headers = {
    --                         ['Content-Type'] = 'application/json',
    --                     },
    --                     models = {
    --                         OLLAMA_MODEL,
    --                         'llama3.2',
    --                         'gemma3',
    --                     },
    --                     resolve_api_key = function()
    --                         return true
    --                     end,
    --                     process_stdout = function(response)
    --                         if response:match 'message' and response:match 'content' then
    --                             local ok, data = pcall(vim.json.decode, response)
    --                             if ok and data.message and data.message.content then
    --                                 return data.message.content
    --                             end
    --                         end
    --                     end,
    --                     get_available_models = function(self)
    --                         local url = self.endpoint:gsub('chat', '')
    --                         local logger = require 'parrot.logger'
    --                         local job = Job
    --                             :new({
    --                                 command = 'curl',
    --                                 args = { '-H', 'Content-Type: application/json', url .. 'tags' },
    --                             })
    --                             :sync()
    --                         local parsed_response = require('parrot.utils').parse_raw_response(job)
    --                         self:process_onexit(parsed_response)
    --                         if parsed_response == '' then
    --                             logger.debug('Ollama server not running on ' .. endpoint_api)
    --                             return {}
    --                         end
    --
    --                         local success, parsed_data = pcall(vim.json.decode, parsed_response)
    --                         if not success then
    --                             logger.error(
    --                                 'Ollama - Error parsing JSON: ' .. vim.inspect(parsed_data)
    --                             )
    --                             return {}
    --                         end
    --
    --                         if not parsed_data.models then
    --                             logger.error "Ollama - No models found. Please use 'ollama pull' to download one."
    --                             return {}
    --                         end
    --
    --                         local names = {}
    --                         for _, model in ipairs(parsed_data.models) do
    --                             table.insert(names, model.name)
    --                         end
    --
    --                         return names
    --                     end,
    --                 },
    --             },
    --         }
    --     end,
    -- },
    -- {
    --     'dlants/magenta.nvim',
    --     lazy = false, -- you could also bind to <leader>mt
    --     build = 'npm install --frozen-lockfile',
    --     opts = {
    --         profiles = {
    --             {
    --                 name = 'ollama',
    --                 provider = 'ollama',
    --                 model = OLLAMA_MODEL,
    --             },
    --             {
    --                 name = 'claude-3-7',
    --                 provider = 'anthropic',
    --                 model = 'claude-3-7-sonnet-latest',
    --                 apiKeyEnvVar = 'ANTHROPIC_API_KEY',
    --             },
    --             {
    --                 name = 'gpt-4o',
    --                 provider = 'openai',
    --                 model = 'gpt-4o',
    --                 apiKeyEnvVar = 'OPENAI_API_KEY',
    --             },
    --         },
    --         -- open chat sidebar on left or right side
    --         sidebarPosition = 'left',
    --         -- can be changed to "telescope" or "snacks"
    --         picker = 'fzf-lua',
    --         -- enable default keymaps shown below
    --         defaultKeymaps = true,
    --         -- keymaps for the sidebar input buffer
    --         sidebarKeymaps = {
    --             normal = {
    --                 ['<CR>'] = ':Magenta send<CR>',
    --             },
    --         },
    --         -- keymaps for the inline edit input buffer
    --         -- if keymap is set to function, it accepts a target_bufnr param
    --         inlineKeymaps = {
    --             normal = {
    --                 ['<CR>'] = function(target_bufnr)
    --                     vim.cmd('Magenta submit-inline-edit ' .. target_bufnr)
    --                 end,
    --             },
    --         },
    --     },
    -- },
    -- {
    --     'olimorris/codecompanion.nvim',
    --     opts = {
    --         strategies = {
    --             -- Change the default chat adapter
    --             chat = {
    --                 adapter = 'ollama',
    --                 model = OLLAMA_MODEL,
    --             },
    --         },
    --     },
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         'nvim-treesitter/nvim-treesitter',
    --     },
    -- },
    -- {
    --     'David-Kunz/gen.nvim',
    --     opts = {
    --         model = OLLAMA_MODEL, -- The default model to use.
    --     },
    -- },
    {
        'nomnivore/ollama.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },

        -- All the user commands added by the plugin
        cmd = { 'Ollama', 'OllamaModel', 'OllamaServe', 'OllamaServeStop' },
        keys = {
            -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
            {
                '<leader>oo',
                ":<c-u>lua require('ollama').prompt()<cr>",
                desc = 'ollama prompt',
                mode = { 'n', 'v' },
            },
            -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
            {
                '<leader>oG',
                ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
                desc = 'ollama Generate Code',
                mode = { 'n', 'v' },
            },
        },
        ---@type Ollama.Config
        opts = {
            -- your configuration overrides
            model = OLLAMA_MODEL,
            prompts = {
                Review_Code = {
                    prompt = 'Review the following code and provide suggestions for improvement.\n'
                        .. 'Please only mention significant issues or areas for enhancement.\n'
                        .. '\n'
                        .. '```$ftype\n'
                        .. '$buf\n'
                        .. '```',
                    model = OLLAMA_MODEL,
                    action = 'display',
                },
                Test_Code = {
                    prompt = 'Please create test cases for this code.\n'
                        .. '\n'
                        .. '```$ftype\n'
                        .. '$sel\n'
                        .. '```',
                    model = OLLAMA_MODEL,
                    action = 'display_insert',
                },
                Document_Code = {
                    prompt = 'Please write a docstring for this code.\n'
                        .. '\n'
                        .. '```$ftype\n'
                        .. '$sel\n'
                        .. '```',
                    model = OLLAMA_MODEL,
                    action = 'display_insert',
                },
                Insert_Code = {
                    prompt = 'Here is my code:\n'
                        .. '\n'
                        .. '```$ftype\n'
                        .. '$before\n'
                        .. '<HERE>\n'
                        .. '$after\n'
                        .. '```\n'
                        .. '\n'
                        .. 'You must generate some new code to go at the <HERE> marker.\n'
                        .. 'Respond EXACTLY in this format:\n'
                        .. '```rust\n'
                        .. '<your code>\n'
                        .. '```\n'
                        .. '\n'
                        .. '$input',
                    input_label = '> ',
                    model = OLLAMA_MODEL,
                    action = 'display',
                },
            },
        },
    },
    -- {
    --     'ThePrimeagen/harpoon',
    --     branch = 'harpoon2',
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    -- },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        config = function()
            local ufo = require('ufo')
            ufo.setup {
                provider_selector = function()
                    return { 'treesitter', 'indent' }
                end,
            }

            vim.opt.foldcolumn = '0' -- '0' is not bad
            vim.opt.foldlevel = 99 -- Using ufo provider needs a large value, feel free to decrease the value
            vim.opt.foldlevelstart = 99
            vim.opt.foldenable = true
        end,
    },
    {
        'https://codeberg.org/esensar/nvim-dev-container',
        event = 'VeryLazy',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {},
    },
    { -- Database tools
        'tpope/vim-dadbod',
        event = 'VeryLazy',
        config = function() end,
    },
    {
        'dawsers/edit-code-block.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'Wansmer/treesj',
        event = 'VeryLazy',
        opts = {},
    },
    -- {
    --     'natecraddock/workspaces.nvim',
    --     dependencies = {
    --         'nvim-telescope/telescope.nvim',
    --     },
    --     event = 'VeryLazy',
    --     opts = {},
    --     config = function()
    --         require('telescope').load_extension('workspaces')
    --         require('workspaces').setup({
    --             hooks = {
    --                 open = { 'Neotree', 'Telescope find_files' },
    --             },
    --         })
    --     end,
    --     keys = { { '<Leader>gw', ':Telescope workspaces<CR>', desc = 'browse [W]orkspaces' } },
    -- },
    {
        'google/executor.nvim',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        event = 'VeryLazy',
        config = function()
            local executor = require('executor')
            executor.setup { use_split = false }
            vim.keymap.set('n', '<leader>xr', executor.commands.run, { desc = 'e[X]ecutor [R]un' })
            vim.keymap.set(
                'n',
                '<leader>xv',
                executor.commands.toggle_detail,
                { desc = 'e[X]ecutor [V]iew' }
            )
        end,
    },
    { 'akinsho/toggleterm.nvim', version = '*', config = true },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            dap.set_log_level('TRACE')
            dap.adapters.python = {
                type = 'executable',
                command = 'python',
                args = { '-m', 'debugpy.adapter' },
            }
            dap.configurations.python = {
                {
                    type = 'python',
                    name = 'Launch File',
                    request = 'launch',
                    program = '${file}',
                },
            }
            vim.keymap.set(
                'n',
                '<Leader>db',
                dap.toggle_breakpoint,
                { desc = '[D]ebug [B]reakpoint' }
            )
            vim.keymap.set('n', '<Leader>dr', dap.repl.toggle, { desc = '[D]ebug [R]epl' })
            vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
            vim.keymap.set('n', '<Leader>do', dap.step_over, { desc = '[D]ebug step [O]ver' })
            vim.keymap.set('n', '<Leader>di', dap.step_into, { desc = '[D]ebug step [I]nto' })
            -- local widgets = require('dap.ui.widgets')
            -- vim.keymap.set('n', '<Leader>dh', function()
            --     local my_sidebar = widgets.sidebar(widgets.scopes)
            --     my_sidebar.open()
            -- end, { desc = '[D]ebug [H]over' })
            -- vim.keymap.set('n', '<Leader>dl', function()
            --     local osv = require('osv')
            --     osv.run_this()
            -- end, { desc = '[D]ebug [L]aunch' })
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
        config = function()
            local dapui = require('dapui')
            dapui.setup()
            vim.keymap.set('n', '<Leader>dp', dapui.toggle, { desc = '[D]ebug [P]anels' })
            vim.keymap.set('n', '<Leader>dh', function()
                dapui.float_element('scopes')
            end, { desc = '[D]ebug [H]over scopes' })
        end,
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = { 'mfussenegger/nvim-dap' },
        opts = {},
    },
    -- {
    --     'renerocksai/telekasten.nvim',
    --     event = 'VeryLazy',
    --     config = function()
    --         local telekasten = require('telekasten')
    --         telekasten.setup({
    --             home = vim.fn.expand('~/telekasten'),
    --         })
    --     end,
    --     keys = {
    --         {
    --             '<Leader>n',
    --             ':Telekasten panel<CR>',
    --             desc = 'Telekasten panel',
    --         },
    --     },
    -- },
    -- {
    --     -- Org Mode
    --     -- Useful shortcuts: https://nvim-orgmode.github.io/features.html
    --     'nvim-orgmode/orgmode',
    --     dependencies = {
    --         { 'nvim-treesitter/nvim-treesitter' },
    --     },
    --     ft = 'org',
    --     config = function()
    --         -- Load treesitter grammar for org
    --         local orgmode = require('orgmode')
    --         -- Setup orgmode
    --         orgmode.setup({
    --             org_agenda_files = '~/orgfiles/**/*',
    --             org_default_notes_file = '~/orgfiles/refile.org',
    --         })
    --         orgmode.setup_ts_grammar()
    --     end,
    -- },
    {
        'toitware/ide-tools',
        ft = { 'toit' },
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. '/start/vim')
        end,
        init = function(plugin)
            require('lazy.core.loader').ftdetect(plugin.dir .. '/start/vim')
        end,
    },
    -- lazy.nvim
    -- {
    --     'robitx/gp.nvim',
    --     config = function()
    --         local conf = {
    --             providers = {
    --                 openai = {
    --                     -- For customization, refer to Install > Configuration in the Documentation/Readme
    --                     secret = '<SECRET>',
    --                 },
    --             },
    --         }
    --         require('gp').setup(conf)
    --
    --         -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    --     end,
    -- },
    -- { -- Bookmarking important files.
    --     'tomasky/bookmarks.nvim',
    --     event = 'VeryLazy',
    --     config = function()
    --         local telescope = require('telescope')
    --         telescope.load_extension('bookmarks')
    --         local bookmarks = require('bookmarks')
    --         bookmarks.setup({
    --             keywords = {
    --                 ['@t'] = '☑️ ', -- mark annotation startswith @t ,signs this icon as `Todo`
    --                 ['@w'] = '⚠️ ', -- mark annotation startswith @w ,signs this icon as `Warn`
    --                 ['@n'] = '📓', -- mark annotation startswith @n ,signs this icon as `Note`
    --             },
    --         })
    --
    --         set_leader_mappings {
    --             { keys = 'ta', fn = bookmarks.bookmark_toggle, desc = 'Bookmark [A]dd/remove' },
    --             { keys = 'tc', fn = bookmarks.bookmark_ann, desc = 'Bookmark [C]lassify' },
    --             { keys = 'tl', fn = telescope.extensions.bookmarks.list, desc = 'Bookmark [L]ist' },
    --         }
    --     end,
    -- },
}
