-- ||||||||||||||||||||||||||||||||| Commands ||||||||||||||||||||||||||||||||| --

local M = {}

local cmd = vim.api.nvim_create_user_command

-- Print-Working-Directory
cmd("PWD", "echo expand('%:p:h')", {})

-- Trim
cmd("Trim", "lua require('rob.utils').trim()", {})

-- Toggle-Color-Column
cmd('TCC', function(opts)
  require("rob.utils").toggle_color_column(opts.args)
end, { nargs = '?' })

-- Plugins
cmd("Plugins", "lua require('rob.utils').plugins()", {})

-- Select-All
cmd("SelectAll", "lua require('rob.utils').select_all()", {})

-- Toggle-Relative-Number
cmd("LN", "lua require('rob.utils').toggle_relative_number()", {})

-- Clear-History
cmd("ClearHistory", "lua require('rob.utils').clear_history()", {})

-- Jump-Brackets
cmd("MoveNext", "lua require('rob.utils').jump_brackets('next')", {})
cmd("MovePrev", "lua require('rob.utils').jump_brackets('prev')", {})

-- Clear-Hover
cmd("ClearHover", "lua require('rob.utils').close_hover_windows()", {})

-- Mac-Open
cmd("MacOpen", "lua require('rob.utils').open_file_with_system_app()", {})

return M
