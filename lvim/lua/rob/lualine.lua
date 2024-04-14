-- ||||||||||||||||||||||||||||||||||| Lualine |||||||||||||||||||||||||||||||| --

local M = {}

local components = require "lvim.core.lualine.components"
lvim.builtin.lualine.sections.lualine_x = {
  components.diagnostics,
  components.lsp,
  components.filetype,
}

return M
