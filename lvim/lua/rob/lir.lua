-- ||||||||||||||||||||||||||||||||||| Lir |||||||||||||||||||||||||||||||||||| --

local M = {}

local actions = require 'lir.actions'
lvim.builtin.lir.mappings['q'] = actions.quit
lvim.builtin.lir.mappings['<leader>q'] = actions.quit
lvim.builtin.lir.mappings['.'] = actions.toggle_show_hidden

return M
