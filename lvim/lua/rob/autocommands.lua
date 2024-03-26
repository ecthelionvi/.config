-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

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

return M
