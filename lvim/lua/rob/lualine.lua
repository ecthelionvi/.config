-- ||||||||||||||||||||||||||||||||||| Lualine |||||||||||||||||||||||||||||||| --

local M = {}

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_x = {
  components.diagnostics,
  components.lsp,
  components.filetype,
}

lvim.builtin.lualine.sections.lualine_c = {
  {
	require('NeoComposer.ui').status_recording,
  padding = { left = 1 },
  },
}

return M
