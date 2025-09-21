-- AI/LLM integration plugins
return {
    {
        'greggh/claude-code.nvim',
        -- 'krisajenkins/claude-code.nvim',
        -- branch = 'floating-window',
        -- Dev-mode settings.
        -- dir = '/Users/krisjenkins/Work/ThirdParty/claude-code.nvim',
        -- dev = true,
        dependencies = {
            'nvim-lua/plenary.nvim', -- Required for git operations
        },
        opts = {
            window = {
                -- split_ratio = 0.8,
                position = 'float',
                float = {
                    width = '95%',
                    height = '95%',
                    relative = 'editor',
                },
            },
        },
    },
}
