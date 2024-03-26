-- |||||||||||||||||||||||||||||||||| Nvim-Tree |||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.filters.dotfiles = true
lvim.builtin.nvimtree.setup.view = { adaptive_size = true }
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.update_focused_file.ignore_list = { "toggleterm", "terminal" }


return M

