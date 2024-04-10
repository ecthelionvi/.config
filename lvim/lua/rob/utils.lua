-- |||||||||||||||||||||||||||||||||| Utils ||||||||||||||||||||||||||||||||||| --

local M = {}

local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set
local opts = { noremap = true, silent = true, buffer = 0 }


function M.save(buf)
  buf = buf or api.nvim_get_current_buf()

  if not api.nvim_buf_get_option(buf, "modified") then
    return
  end

  api.nvim_buf_call(buf, function()
    cmd("silent! write")
  end)
end

function M.debounce(lfn, duration)
  local queued = false
  return function()
    if not queued then
      vim.defer_fn(function()
        queued = false
        lfn()
      end, duration)
      queued = true
    end
  end
end

function M.save_func()
  M.debounce(M.save, 300)()
end

-- Select-All
function M.select_all()
  cmd("normal! VGo1G | gg0")
end

-- Text-Object-Line
function M.line_inner()
  cmd('silent! normal! m`')
  cmd('silent! keepj normal! ^vg_')
  cmd('silent! normal! o')
end

-- Trim
function M.trim()
  local save = fn.winsaveview()
  cmd("keeppatterns %s/\\s\\+$\\|\\r$//e")
  fn.winrestview(save)
end

-- Close
function M.close_buffer()
  local bufnr = api.nvim_get_current_buf()
  local bt = vim.bo.buftype

  if bt:match("nofile") then
    cmd("bd")
  elseif M.count_buffers() == 1 then
    cmd('Alpha | bd ' .. bufnr)
  else
    cmd('BufferKill')
  end
end

-- Toggle-Hover
function M.toggle_lsp_buf_hover()
  if M.close_hover_windows() then return end
  vim.lsp.buf.hover()
end

-- Toggle-Diagnostic-Float
function M.toggle_diagnostic_hover()
  if M.close_hover_windows() then return end
  -- local config = lvim.lsp.diagnostics.float
  -- config.scope = "line"
  vim.diagnostic.open_float()
end

-- Close-All-Hidden
function M.close_all_hidden()
  local bufnums = api.nvim_list_bufs()
  for _, bufnr in ipairs(bufnums) do
    local bufname = fn.bufname(bufnr)
    local is_term = bufname:match('^term://')
    if is_term and fn.bufwinnr(bufnr) == -1 then
      cmd('bwipeout ' .. bufnr)
    end
  end
end

-- Relative Number
function M.toggle_relative_number()
  vim.o.relativenumber = not vim.o.relativenumber
end

-- Dashboard
function M.dashboard()
  local bt = vim.bo.buftype
  local ft = vim.bo.filetype
  if M.count_buffers() == 0 and ft == "alpha" then
    return
  end
  if bt == "terminal" then
    cmd("ToggleTerm")
  end
  cmd("Alpha")
end

-- Count-Buffers
function M.count_buffers()
  return vim.tbl_count(vim.tbl_filter(function(bufnr)
    return fn.buflisted(bufnr) == 1
  end, api.nvim_list_bufs()))
end

-- Plugins
function M.plugins()
  local filepath = "~/.config/lvim/lua/rob/plugins.lua"
  cmd("edit " .. filepath)
end

-- Hide_Filetype
function M.hide_filetype()
  local ft = { "lazy", "harpoon", "noice",
    --[[ "NvimTree", ]] "toggleterm", "TelescopePrompt" }
  if vim.tbl_contains(ft, vim.bo.filetype)
  then
    api.nvim_buf_set_option(0, 'filetype', '')
  end
end

-- Cwd-Set-Options
function M.cwd_set_options()
  local ft = vim.bo.filetype
  local dir = fn.expand('%:h')
  vim.g.copilot_no_tab_map = true
  vim.o.fo = vim.o.fo:gsub("[cro]", "")
  if ft == "alpha" and M.count_buffers() > 0 then return end
  if fn.isdirectory(dir) and ft ~= "" then fn.chdir(dir) end
end

-- Jump-Brackets
function M.jump_brackets(dir)
  local pattern = [[(\|)\|\[\|\]\|{\|}\|"\|`\|''\|<\|>]]
  dir = dir == "prev" and "b" or "n"
  local result = fn.searchpos(pattern, dir)
  local lnum, col = result[1], result[2]
  if result and #result >= 2 then
    if lnum == 0 and col == 0 then return end
    fn.setpos('.', { 0, lnum, col, 0 })
  end
end

-- Nvim-Tree-Open
function M.open_file_with_system_app()
  local lib = require 'nvim-tree.lib'
  local node = lib.get_node_at_cursor()
  if node and node.fs_stat then
    cmd('silent !open ' .. fn.shellescape(node.absolute_path))
  end
end

-- Close-Hover-Windows
function M.close_hover_windows()
  local win_ids = api.nvim_list_wins()
  local floating_wins = vim.tbl_filter(function(win_id)
    local win_config = api.nvim_win_get_config(win_id)
    return win_config.relative ~= ''
  end, win_ids)
  if vim.tbl_isempty(floating_wins) then return false end
  vim.tbl_map(function(bufnr)
    local buftype = api.nvim_buf_get_option(bufnr, 'buftype')
    local filetype = api.nvim_buf_get_option(bufnr, 'filetype')
    if buftype == 'nofile' and filetype ~= 'alpha' then
      api.nvim_buf_delete(bufnr, { force = true })
    end
  end, api.nvim_list_bufs())
  return true
end

-- Special-Keymaps
function M.special_keymaps()
  local bt = vim.bo.buftype
  local ft = vim.bo.filetype
  local bf = api.nvim_get_current_buf()
  local bn = api.nvim_buf_get_name(bf)
  if bt:match("acwrite") then
    map("n", "|", "<nop>", opts)
  end
  if bn:match("lazygit") then
    map("t", "<esc>", "<esc>", opts)
  end
  if ft == "alpha" then
    map("n", "<leader>k", "<Nop>", opts)
  end
  if bn:match("ranger") then
    map("t", "<esc>", "<cmd>clo!<cr>", opts)
  end
  if bn:match("crunner_") then
    map("n", "<leader>q", "<cmd>RunClose<cr>", opts)
  end
  if bn:match("NvimTree_") then
    map("n", "<leader>;", "<Nop>", opts)
    map("n", "<s-cr>", "<cmd>MacOpen<cr>", opts)
    map("n", "<leader>k", "<cmd>NvimTreeToggle<cr>", opts)
    map("n", "<leader>q", "<cmd>NvimTreeToggle<cr>", opts)
  end
  if bt:match("nofile") then
    map("n", "<esc>", "<cmd>clo!<cr>", opts)
  end
  if vim.tbl_contains({ "qf", "help", "man", "noice" }, ft) then
    map("n", "q", "<cmd>clo!<cr>", opts)
  end
end

-- Toggle-Color-Column
function M.toggle_color_column(column)
  if vim.b.color_column_enabled then
    vim.opt_local.colorcolumn = ''
    vim.b.color_column_enabled = false
  else
    local current_column = column and tonumber(column) or vim.fn.col('.')
    if current_column and current_column > 0 then
      vim.opt_local.colorcolumn = tostring(current_column)
      vim.b.color_column_enabled = true
    end
  end
end

-- Toggle-Diagnostics
function M.toggle_lsp_diagnostics()
  local bufnr = api.nvim_get_current_buf()
  local diagnostics_hidden = pcall(api.nvim_buf_get_var, bufnr, 'diagnostics_hidden')
      and api.nvim_buf_get_var(bufnr, 'diagnostics_hidden')
  api.nvim_buf_set_var(bufnr, 'diagnostics_hidden', not diagnostics_hidden)
  if diagnostics_hidden then
    vim.diagnostic.show()
    return
  end
  vim.diagnostic.hide()
end

-- Close-Nvim-Tree
function M.close_nvim_tree()
  if M.count_buffers() == 0 and vim.tbl_count(vim.tbl_filter(function(win_id)
        return api.nvim_buf_get_name(api.nvim_win_get_buf(win_id)):match('NvimTree_')
      end, api.nvim_list_wins())) > 0 then
    cmd('NvimTreeToggle')
  end
end

-- Clear-History
function M.clear_history()
  local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-\"*+#"
  for char in chars:gmatch(".") do fn.setreg(char, {}) end
  cmd("messages clear")
  fn.histdel(":")
end

-- Code-Runner
function M.code_runner()
  local crunner_bufs = vim.tbl_filter(function(buffer)
    return string.match(fn.bufname(buffer), 'crunner_')
  end, api.nvim_list_bufs())
  return #crunner_bufs > 0 and "<cmd>silent! bd " .. crunner_bufs[1] .. "<cr>" or "<cmd>silent! RunCode<cr>"
end

return M
