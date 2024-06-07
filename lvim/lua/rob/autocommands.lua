-- ||||||||||||||||||||||||||||||| Autocommands ||||||||||||||||||||||||||||||| --

local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opts = { noremap = true, silent = true, buffer = 0 }

-- Set up the autocommand to perform the insert and delete actions when a Dart file is opened
-- vim.api.nvim_create_autocmd('BufReadPost', {
--   pattern = '*.dart',
--   group = vim.api.nvim_create_augroup('DartAutoCommand', { clear = true }),
--   callback = function()
--     -- Enter insert mode, insert a space, and delete it
--     vim.api.nvim_command('normal! i ')
--     vim.api.nvim_command('normal! <BS>')
--   end,
-- })

-- Save-Cursor
vim.api.nvim_create_autocmd('BufWinEnter', {
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

-- Lir-Keymaps
autocmd("FileType", {
  group = augroup("lir_keymaps", { clear = true }),
  pattern = "lir",
  callback = function()
    vim.schedule(function()
      pcall(function() require("rob.utils").lir_keymaps() end)
    end)
  end,
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

-- Highlight-URL
autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  group = augroup("highlighturl", { clear = true }),
  callback = function() require('rob.utils').set_url_match() end,
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
autocmd("QuitPre", {
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

-- Yank-Highlight
autocmd('TextYankPost', {
  group = 'PreserveCursorYank',
  callback = function()
    if vim.v.event.operator == 'y' and vim.b.pre_yank_cursor_pos then
      vim.api.nvim_win_set_cursor(0, vim.b.pre_yank_cursor_pos)
    end
    vim.highlight.on_yank({ higroup = 'Search', timeout = 350 })
  end,
})

-- Go-Auto-Imports
autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end
})
return M
