------------------------------------------------------------
-- Support Utils
------------------------------------------------------------
M = {}

---@class LeaderMapping
---@field keys string
---@field fn fun() | string
---@field desc string

---@param mappings LeaderMapping[]
M.set_leader_mappings = function(mappings)
    for _, mapping in ipairs(mappings) do
        vim.keymap.set('n', '<Leader>' .. mapping.keys, mapping.fn, { desc = mapping.desc })
    end
end

return M
