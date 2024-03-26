-- ||||||||||||||||||||||||||||||||| Commands ||||||||||||||||||||||||||||||||| --

local M = {}

local cmd = vim.api.nvim_create_user_command

-- Trim
cmd("Trim", "lua require('rob.utils').trim()", {})

-- Select-All
cmd("SelectAll", "lua require('rob.utils').select_all()", {})

-- Clear-History
cmd("ClearHistory", "lua require('rob.utils').clear_history()", {})

-- Jump-Brackets
cmd("MoveNext", "lua require('rob.utils').jump_brackets('next')", {})
cmd("MovePrev", "lua require('rob.utils').jump_brackets('prev')", {})

-- Print-Working-Directory
cmd("PWD", "echo expand('%:p:h')", {})

-- Clear-Hover
cmd("ClearHover", "lua require('rob.utils').close_hover_windows()", {})

-- Mac-Open
cmd("MacOpen", "lua require('rob.utils').open_file_with_system_app()", {})

-- Toggle-Cursor-Column
cmd("ToggleCursorColumn", "lua require('rob.utils').toggle_cursor_column()", {})

-- Toggle-Relative-Number
cmd("ToggleRelativeNumber", "lua require('rob.utils').toggle_relative_number()", {})


return M
