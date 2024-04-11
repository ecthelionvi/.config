-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup


vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = augroup("auto-save", { clear = true }),
  pattern = '*',
  command = 'silent! normal! g`"zv',
})

-- Auto-Save
autocmd({ "InsertLeave", "TextChanged" }, {
  group = "auto-save",
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").save_func() end)
    end)
  end,
  pattern = "*",
})

-- Hide-Filetype
autocmd("FileType", {
  group = augroup("hide-filetype", { clear = true }),
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").hide_filetype() end)
    end)
  end,
})

-- Close-Nvim-Tree
autocmd("BufDelete", {
  group = augroup("nvim-tree", { clear = true }),
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").close_nvim_tree() end)
    end)
  end,
})

-- Quit-Nvim-Tree
autocmd({ "QuitPre" }, {
  group = "nvim-tree",
  callback = function()
    pcall(function() vim.cmd("NvimTreeClose") end)
    pcall(function() require("rob.utils").close_all_hidden() end)
  end
})

-- Change-Directory .. Special-Keymaps
autocmd({ "BufNew", "BufWinEnter" }, {
  group = augroup("miscellaneous", { clear = true }),
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").cwd_set_options() end)
      pcall(function() require("rob.utils").special_keymaps() end)
    end)
  end,
})


-- Preserve-Cursor-Yank
autocmd({ 'VimEnter', 'CursorMoved' }, {
  group = augroup('PreserveCursorYank', { clear = true }),
  callback = function()
    vim.b.pre_yank_cursor_pos = vim.api.nvim_win_get_cursor(0)
  end,
})

autocmd('TextYankPost', {
  group = 'PreserveCursorYank',
  callback = function()
    if vim.v.event.operator == 'y' and vim.b.pre_yank_cursor_pos then
      vim.api.nvim_win_set_cursor(0, vim.b.pre_yank_cursor_pos)
    end
    vim.highlight.on_yank({ higroup = 'Search', timeout = 250 })
  end,
})

return M
