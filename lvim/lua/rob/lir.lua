-- ||||||||||||||||||||||||||||||||||| Lir |||||||||||||||||||||||||||||||||||| --

local M = {}

local actions = require 'lir.actions'
lvim.builtin.lir.mappings['.'] = actions.toggle_show_hidden

return M
