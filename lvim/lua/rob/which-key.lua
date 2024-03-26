-- |||||||||||||||||||||||||||||||| Which-Key ||||||||||||||||||||||||||||||||| --

local M = {}

lvim.builtin.which_key.setup.show_keys = false
lvim.builtin.which_key.setup.show_help = false
lvim.builtin.which_key.setup.ignore_missing = true
lvim.builtin.which_key.setup.layout.align = "center"

lvim.builtin.which_key.mappings = {

  -- Plugins
  p = {
    name = "Plugins",
    l = { "<cmd>Lazy log<cr>", "Log" },
    s = { "<cmd>Lazy sync<cr>", "Sync" },
    c = { "<cmd>Lazy clean<cr>", "Clean" },
    d = { "<cmd>Lazy debug<cr>", "Debug" },
    S = { "<cmd>Lazy clear<cr>", "Status" },
    u = { "<cmd>Lazy update<cr>", "Update" },
    p = { "<cmd>Lazy profile<cr>", "Profile" },
    i = { "<cmd>Lazy install<cr>", "Install" },
  },

  -- Buffer
  b = {
    name = "Buffers",
    W = { "<cmd>noautocmd w<cr>", "Save" },
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
    k = { "<cmd>BufferLinePickClose<cr>", "Close" },
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close All 󰧀" },
    l = { "<cmd>BufferLineCloseRight<cr>", "Close All 󰧂", },
    f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
    L = { "<cmd>BufferLineSortByExtension<cr>", "Sort Language" },
    D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort Directory" },
  },

  --Trouble
  t = {
    name = "+Trouble",
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  },

  -- Debug
  d = {
    name = "Debug",
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  },

  -- LSP
  l = {
    name = "LSP",
    i = { "<cmd>LspInfo<cr>", "Info" },
    r = { vim.lsp.buf.rename, "Rename" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    f = { require("lvim.lsp.utils").format, "Format" },
    j = { vim.diagnostic.goto_next, "Next Diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    p = { function() require('rob.utils').toggle_lsp_diagnostics() end, "Show/Hide" },
    S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
  },

  -- Git
  g = {
    name = "Git",
    c = { "<cmd>Telescope git_commits<cr>", "Commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
    o = { "<cmd>Telescope git_status<cr>", "Open Changed File" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Commit File" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    g = { "<cmd>lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
  },

  -- Search
  s = {
    name = "Search",
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    y = { "<cmd>Telescope yank_history<cr>", "Yank History" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
    H = { "<cmd>Telescope highlights<cr>", "Find Highlight Groups" },
    f = { "<cmd>Telescope find_files search_dirs={'$HOME'}<cr>", "Find File" },
    c = { "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", "Colorscheme" },
  },

  -- Dashboard
  ["q"] = { "<cmd>silent! q<cr>", "Quit" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
  ["h"] = { "<cmd>ToggleNeoColumn<cr>", "ColorColumn" },
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
  [";"] = { function() require('rob.utils').dashboard() end, "Dashboard" },
  ["k"] = { function() require('rob.utils').close_buffer() end, "Close Buffer" },
  ["f"] = { function() require("lvim.core.telescope.custom-finders").find_project_files() end, "Find File" },

  -- LunarVim
  L = {
    name = "+LunarVim",
    u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
    d = { "<cmd>LvimDocs<cr>", "View LunarVim Docs" },
    r = { "<cmd>LvimReload<cr>", "Reload LunarVim Configuration" },
    k = { "<cmd>Telescope keymaps<cr>", "View LunarVim Keymappings" },
    c = { "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>", "Edit Config" },
    i = { "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>", "Toggle LunarVim Info" },
    f = { "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>", "Find LunarVim Files" },
    g = { "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>", "Grep LunarVim Files" },
    I = { "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
      "View LunarVim Changelog" },
    l = {
      name = "+Logs",
      N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open Neovim Logfile" },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open LSP Logfile" },
      l = { "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>", "View LSP Log" },
      D = { "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>", "Open Default Logfile" },
      n = { "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>", "View Neovim Log" },
      d = { "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        "View Default Log" },
    },
  },
}

return M
