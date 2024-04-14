-- ||||||||||||||||||||||||||||||||| Plugins |||||||||||||||||||||||||||||||||| --

local M = {}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

lvim.plugins = {

  -- Vimwiki
  {
    "vimwiki/vimwiki",
    event = "VeryLazy",
  },

  -- Repeat
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Accerlated-JK
  {
    "rhysd/accelerated-jk",
    event = "VeryLazy",
  },

  -- Neoscroll
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = { mappings = {}, }
  },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },

  -- Noice
  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  -- Rainbow-CSV
  {
    "mechatroner/rainbow_csv",
    event = "VeryLazy",
  },

  -- Notify
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        timeout = 500,
      })
    end
  },

  -- Puppeteer
  {
    "chrisgrieser/nvim-puppeteer",
    event = "VeryLazy",
  },

  -- Cutlass
  {
    "gbprod/cutlass.nvim",
    event = "VeryLazy",
    config = function()
      require("cutlass").setup({
        exclude = { "ns", "nS" },
        cut_key = "m",
        override_del = true,
      })
    end
  },

  -- Python-Indent
  {
    "Vimjas/vim-python-pep8-indent",
    event = "BufRead",
  },

  -- Rainbow-Delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },

  -- Various-Textobjs
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = "BufRead",
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = "BufRead",
    config = function()
      require("nvim-surround").setup()
    end
  },

  -- Context
  {
    "ecthelionvi/nvim-treesitter-context",
    event = "BufRead",
    opts = {}
  },

  -- CamelCaseMotion
  {
    "bkad/CamelCaseMotion",
    event = "VeryLazy",
    map("n", "w", "<Plug>CamelCaseMotion_w",
      opts),
    map("n", "b", "<Plug>CamelCaseMotion_b",
      opts),
    map("n", "e", "<Plug>CamelCaseMotion_e",
      opts),
    map("n", "ge", "<Plug>CamelCaseMotion_ge",
      opts),
    map("o", "iw", "<Plug>CamelCaseMotion_iw",
      opts),
    map("x", "iw", "<Plug>CamelCaseMotion_iw",
      opts),
  },

  -- Hop
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      map("n", "S", "<cmd>HopWord<cr>", opts)
      map("n", "s", "<cmd>HopChar2<cr>", opts)
    end,
  },

  -- Mini
  {
    "echasnovski/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      local gen_spec = require('mini.ai').gen_spec
      require("mini.ai").setup({
        mappings = {
          around_next = '',
          inside_next = '',
          around_last = '',
          inside_last = '',
        },
        custom_textobjects = {
          [','] = gen_spec.argument()
        }
      })
      require("mini.move").setup({
        mappings = {
          left = '<m-left>',
          right = '<m-right>',
          down = '<m-down>',
          up = '<m-up>',
          line_left = '<m-left>',
          line_right = '<m-right>',
          line_down = '<m-down>',
          line_up = '<m-up>',
        },
      })
    end
  },

  -- Undotree
  {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", opts)
    end
  },

  -- TreeSJ
  {
    'Wansmer/treesj',
    event = "BufRead",
    dependencies = { 'nvim-treesitter' },
    config = function()
      require('treesj').setup({ use_default_keymaps = false })
    end,
    map("n", "zz", "<cmd>TSJToggle<cr>", opts)
  },

  -- Dial
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.hex,
          augend.constant.alias.alpha,
          augend.integer.alias.decimal,
          augend.date.alias["%m/%d/%Y"],
          augend.constant.new {
            elements = { "and", "or" },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "&&", "||" },
            word = false,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "true", "false" },
            word = true,
            cyclic = true,
          },
          augend.constant.new {
            elements = { "True", "False" },
            word = true,
            cyclic = true,
          },
        },
      }
      map("n", "<c-'>", require("dial.map").inc_normal(), opts)
      map("n", "<c-;>", require("dial.map").dec_normal(), opts)
      map("x", "<c-'>", require("dial.map").inc_visual(), opts)
      map("x", "<c-;>", require("dial.map").dec_visual(), opts)
      map("x", "g<c-'>", require("dial.map").inc_gvisual(), opts)
      map("x", "g<c-;>", require("dial.map").dec_gvisual(), opts)
    end
  },

  -- Nvim-Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },

  -- Silicon
  {
    'krivahtoo/silicon.nvim',
    event = 'VeryLazy',
    build = './install.sh build',
    config = function()
      require('silicon').setup({
        font = 'JetBrainsMonoNerdFont=26',
        background = '#87f',
        theme = 'tokyonight_night',
        line_number = true,
        pad_vert = 80,
        pad_horiz = 50,
        output = {
          clipboard = false,
          path = "/Users/rob/Documents/Screenshots",
          format = "silicon_[year][month][day]_[hour][minute][second].png"
        },
        watermark = {
          text = ' @ecthelionvi',
        },
        window_title = function()
          return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ':~:.')
        end,
      })
    end
  },

  -- Copilot
  {
    "github/copilot.vim",
    event = "BufRead",
    config = function()
      vim.g.copilot_filetypes = {
        [""] = false,
        lazy = false,
        TelescopePrompt = false,
        TelescopeResults = false,
      }
      vim.g.copilot_no_tab_map = true
      vim.cmd("imap <silent><script><expr> <s-cr> copilot#Accept('\\<CR>')")
    end
  },

  --Rnvimr
  {
    "kevinhwang91/rnvimr",
    event = "VeryLazy",
    config = function()
      vim.g.rnvimr_bw_enable = 1
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_presets = { { width = 0.890, height = 0.840 } }
      map("n", "<leader>.", "<cmd>RnvimrToggle<cr><cmd>setlocal filetype=<cr>",
        opts)
    end
  },

  -- Markdown-Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Substitute
  {
    "gbprod/substitute.nvim",
    event = "VeryLazy",
    config = function()
      require("substitute").setup({
        map("n", "cxx", "<cmd>lua require('substitute.exchange').line()<cr>", opts),
        map("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", opts),
        map("n", "cc", "<cmd>lua require('substitute.exchange').cancel()<cr>", opts),
        map("n", "cx", "<cmd>lua require('substitute.exchange').operator()<cr>", opts),
      })
    end
  },

  -- Persistence
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    map("n", "<leader>,", "<cmd>lua require('persistence').load({ last = true })<cr>", opts)
  },

  -- Code-Runner
  {
    "CRAG666/code_runner.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require('code_runner').setup {
        mode = "term",
        term = {
          position = "bot",
          size = 18,
        },
        startinsert = false,
        focus = true,
        filetype = {
          javascript = "node",
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
          cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
          python = "python3 -u",
          sh = "bash",
          rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
        },
        map("n", "<leader>r", function()
          return require('rob.utils').code_runner()
        end, { noremap = true, silent = true, expr = true, })
      }
    end,
  },
}

return M
