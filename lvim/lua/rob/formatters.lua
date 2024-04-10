-- ||||||||||||||||||||||||||||||||| Formatters ||||||||||||||||||||||||||||||| --

local M = {}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" }, extra_args = { "--fast" }, },
  { name = "prettier", args = { "--print-width", "100" } },
}

return M

