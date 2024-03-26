-- ||||||||||||||||||||||||||||||| Treesitter ||||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.treesitter.auto_install = true
lvim.builtin.treesitter.ensure_installed = { "vim", "regex" }
lvim.builtin.treesitter.incremental_selection = {
  enable = true,
  keymaps = {
    -- init_selection = "gnn",
    node_incremental = "v",
    node_decremental = "V",
    -- scope_incremental = "grc",
  },
}

return M

