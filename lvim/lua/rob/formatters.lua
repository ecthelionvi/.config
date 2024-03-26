-- ||||||||||||||||||||||||||||||||| Formatters ||||||||||||||||||||||||||||||| --

local M = {}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = { "--fast" }, },
}

return M