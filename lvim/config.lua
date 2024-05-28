-- |||||||||||||||||||||||||||||||||| Config |||||||||||||||||||||||||||||||||| --

local M = {}

-- Modules
reload("rob.lir")
reload("rob.lsp")
reload("rob.noice")
reload("rob.utils")
reload("rob.remaps")
reload("rob.lualine")
reload("rob.plugins")
reload("rob.project")
reload("rob.vimwiki")
reload("rob.session")
reload("rob.commands")
reload("rob.autopairs")
reload("rob.nvim-tree")
reload("rob.telescope")
reload("rob.which-key")
reload("rob.formatters")
reload("rob.treesitter")
reload("rob.toggleterm")
reload("rob.illuminate")
reload("rob.autocommands")

vim.o.verbose = 0
vim.o.tabstop = 2
vim.o.title = true
vim.o.cmdheight = 0
vim.o.shiftwidth = 2
vim.o.timeoutlen = 300
vim.o.shortmess = "FOW"
vim.o.maxfuncdepth = 1000
vim.o.fillchars = "eob: "
vim.g.color_column = true
vim.o.relativenumber = true
vim.o.titlestring = "%f - LunarVim"

vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = '↪\\ '


-- vim.api.nvim_set_keymap('n', '<S-ScrollWheelUp>', ':echo "Scrolled up!"<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-ScrollWheelDown>', ':echo "Scrolled down!"<CR>', { noremap = true, silent = true })

return M
