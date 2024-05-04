local M = {}

-- Helper function to ensure the session directory exists
function M.ensure_directory_exists()
  local cache_dir = vim.fn.expand("~/.cache/sessions")
  if vim.fn.isdirectory(cache_dir) == 0 then
    vim.fn.mkdir(cache_dir, "p")
  end
  return cache_dir
end

-- Function to save the session to a JSON file
function M.save_session()
  local wins = vim.api.nvim_list_wins()
  local session_info = {
    windows = {},
    buffers = {}
  }
  local current_win = vim.api.nvim_get_current_win()

  -- Capture all buffers first
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    local file_type = vim.api.nvim_buf_get_option(buf, 'filetype')

    local is_valid = vim.api.nvim_buf_is_loaded(buf) and
        buf_name ~= "" and
        not buf_name:match('^term://') and
        file_type ~= ""

    local unwanted_filetypes = { "netrw", "nerdtree", "fugitive", "NvimTree", "quickfix" }
    if is_valid and not vim.tbl_contains(unwanted_filetypes, file_type) then
      table.insert(session_info.buffers, {
        path = buf_name,
        is_current = (vim.api.nvim_get_current_buf() == buf)
      })
    end
  end

  -- Capture window layout with associated buffer indices
  for i, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    for j, buffer in ipairs(session_info.buffers) do
      if vim.api.nvim_buf_get_name(buf) == buffer.path then
        table.insert(session_info.windows, {
          buffer_index = j,
          is_current = (win == current_win)
        })
        break
      end
    end
  end

  local json_data = vim.json.encode(session_info)
  local cache_dir = M.ensure_directory_exists()
  local filepath = cache_dir .. "/session.json"
  local file = io.open(filepath, "w")
  file:write(json_data)
  file:close()
end

-- Function to load the session from a JSON file
function M.load_session()
  local cache_dir = vim.fn.expand("~/.cache/sessions")
  local filepath = cache_dir .. "/session.json"
  local file = io.open(filepath, "r")
  if file then
    local json_data = file:read("*a")
    local session_info = vim.json.decode(json_data)
    local focus_buffer_index = nil

    -- Load all buffers first without focusing them
    for i, buf_info in ipairs(session_info.buffers) do
      vim.cmd('edit ' .. buf_info.path)
      if buf_info.is_current then
        focus_buffer_index = i
      end
    end

    -- Load windows with previously associated buffers
    for _, win_info in ipairs(session_info.windows) do
      vim.cmd('buffer ' .. session_info.buffers[win_info.buffer_index].path)
      if win_info.is_current then
        focus_buffer_index = win_info.buffer_index
      end
    end

    -- Focus the previously active buffer
    if focus_buffer_index then
      vim.cmd('buffer ' .. session_info.buffers[focus_buffer_index].path)
    end
    file:close()
  else
    print("Session file not found")
  end
end

-- Autocommand to save the session automatically when Neovim quits
vim.api.nvim_create_autocmd("QuitPre", {
  pattern = '*',
  callback = function()
    M.save_session() -- Save the session automatically on quitting Neovim
  end,
})

-- User commands for manual session management
vim.api.nvim_create_user_command('SaveSession', M.save_session, {})
vim.api.nvim_create_user_command('LoadSession', M.load_session, {})

return M

