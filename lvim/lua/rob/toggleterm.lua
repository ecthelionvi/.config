-- ||||||||||||||||||||||||||||||||| Toggleterm ||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.terminal.active = true
lvim.builtin.terminal.autochdir = true
lvim.builtin.terminal.direction = "vertical"
lvim.builtin.terminal.size = vim.api.nvim_win_get_width(0) / 2

return M
