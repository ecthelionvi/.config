-- &&|||||||||||||||||||||||||||||||||| LSP ||||||||||||||||||||||||||||||||||| --

local M = {}

-- Semantic-Tokens
lvim.lsp.on_attach_callback = function(client, _)
  client.server_capabilities.semanticTokensProvider = nil
end

-- Disbale Messages
vim.lsp.set_log_level("warn")

-- TSServer
require('lspconfig').tsserver.setup({
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

-- Pyright
require('lspconfig').pyright.setup({
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          ["reportGeneralTypeIssues"] = "none",
        },
      },
    },
  },
})

-- Keymaps
lvim.lsp.buffer_mappings.normal_mode['K'] = nil
lvim.lsp.buffer_mappings.normal_mode["gl"] = nil
lvim.lsp.buffer_mappings.normal_mode['gK'] = { vim.lsp.buf.hover, "Show hover" }

return M
