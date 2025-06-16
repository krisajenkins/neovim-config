-- AI/LLM integration plugins

-- local OLLAMA_MODEL = 'deepseek-coder-v2'
local OLLAMA_MODEL = 'qwen2.5-coder:32b'

return {
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

    -- Commented out AI plugins available in evaluating.lua.old:
    -- jackMort/ChatGPT.nvim, github/copilot.vim, supermaven-inc/supermaven-nvim
    -- zbirenbaum/copilot.lua, sourcegraph/sg.nvim, TobinPalmer/rayso.nvim
    -- aduros/ai.vim, robitx/gp.nvim, David-Kunz/gen.nvim
}