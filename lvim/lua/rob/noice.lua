-- |||||||||||||||||||||||||||||||||| Noice ||||||||||||||||||||||||||||||||||| --

local M = {}

local status_ok, noice = pcall(require, "noice")
if not status_ok then
  return
end

noice.setup {
  messages = {
    view = "notify",
    view_search = false,
  },
  lsp = {
    hover = {
      enabled = false,
    },
    progress = {
      enabled = false,
    },
    signature = {
      enabled = false,
      auto_open = { enabled = false },
    },
    override = {
      ["vim.lsp.rust_analyzer"] = false,
    },
  },
  routes = {
    {
      filter = { event = "msg_show", find = "->" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Hop" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E21" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E35" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E37" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E149" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E353" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E444" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "E486" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "fewer" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "after" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "before" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "yanked" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "search" },
      opts = { skip = true },
    },
    {
      filter = { event = "notify", find = "Register" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "written" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "harpoon" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "substitutions" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "AutoSave: saved at" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Not an editor command" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "--No lines in buffer--" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Already at oldest change" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Already at newest change" },
      opts = { skip = true },
    },
    {
      filter = { event = "msg_show", find = "Error executing vim.schedule lua callback" },
      opts = { skip = true },
    },
    {
      filter = { event = "notify", find = "Your last action was not put, ignoring cycle" },
      opts = { skip = true },
    },
    {
      filter = {
        event = "notify",
        find = [[Cannot "join" node longer than 120 symbols. Check your settings to change it.]]
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "notify",
        find = [[5 git jobs have timed out after 200ms, disabling git integration.Try increasing git.timeout]]
      },
      opts = { skip = true },
    },
  },
  views = {
    popup = {
      backend = "popup",
      relative = "editor",
      close = {
        events = { "BufLeave" },
        keys = { "q" },
      },
      enter = true,
      border = {
        style = "rounded",
      },
      position = "50%",
      size = {
        width = "120",
        height = "20",
      },
      win_options = {
        winhighlight = { Normal = "NoicePopup", FloatBorder = "NoicePopupBorder" },
      },
    },
  },
  cmdline = {
    view = "cmdline",
    format = {
      lua = false,
      help = false,
      search_up = { kind = "search", pattern = "^%?", icon = "󱡁", lang = "regex" },
      search_down = { kind = "search", pattern = "^/", icon = "󱡁", lang = "regex" },
    },
  },
}

return M
