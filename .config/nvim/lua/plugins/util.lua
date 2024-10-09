return {
  { "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically

  { "numToStr/Comment.nvim", opts = {} }, -- "gc" to comment visual regions/lines

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    config = function() -- This is the function that runs, AFTER loading
      local wk = require("which-key")

      -- Document existing key chains
      wk.setup({
        preset = "modern",
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>f", group = "[F]ile" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>q", group = "[Q]uit" },
        { "<leader>g", group = "[G]it" },
        { "<leader>w_", hidden = true },
      })
    end,
  },
  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      --[[
      local statusline = require("mini.statusline")
        -- set use_icons to true if you have a Nerd Font
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      Set the section for cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
      --]]
      require("mini.misc").setup()
      require("mini.pairs").setup({
        modes = { insert = true, command = true, terminal = false },
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=], -- skip autopair when next character is one of these
        skip_ts = { "string" }, -- skip autopair when the cursor is inside these treesitter nodes
        skip_unbalanced = true, -- skip autopair when next character is closing pair and there are more closing pairs than opening pairs
        markdown = true, -- better deal with markdown code blocks
      })
      require("mini.splitjoin").setup()
      require("mini.move").setup()
      --[[
      require("mini.indentscope").setup({
        symbol = "▏",
        draw = { animation = require("mini.indentscope").gen_animation.none() },
      }) --]]
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  --[[
  {
    'echasnovski/mini.hipatterns',
    config = function()
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
    },
  --]]
  {
    "kyazdani42/nvim-web-devicons",
    opts = {},
  },

  --[[
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({})
    end,
  },
  --]]
}
