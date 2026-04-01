-- Oversight (dev plugin)
require('oversight').setup()

-- NeoJJ (dev plugin)
local neojj = require('neojj')
neojj.setup()

local utils = require('utils')
local set_leader_mappings = utils.set_leader_mappings
set_leader_mappings({
    { keys = 'js', fn = neojj.jj_status, desc = 'JJ Status' },
    { keys = 'jl', fn = neojj.jj_log, desc = 'JJ Log' },
    { keys = 'ja', fn = neojj.jj_annotate, desc = 'JJ Log' },
})
