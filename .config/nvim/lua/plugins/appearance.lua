return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            "diagnostics",
          },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {
          "nvim-tree",
          "nvim-dap-ui",
        },
      })
    end,
  },
  { -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = function()
      return {
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "nvim-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      }
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "folke/tokyonight.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme("tokyonight-night")

      -- You can configure highlights by doing something like:
      vim.cmd.hi("Comment gui=none")
    end,
  },
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = function()
      -- This logo and it's "font" is based on the logo of LazyVim
      -- The current setup of the dashboard as well
      local logo = [[
█████╗  ███████╗███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗
██╔══█╗ ██╔════╝████╗  ██║██╔════╝██║   ██║██║████╗ ████║
█████╔╝ █████╗  ██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║
██╔══██╗██╔══╝  ██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝███████╗██║ ╚███╔╝███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝ ╚══════╝╚═╝  ╚══╝ ╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore start
          center = {
            {
              action = function()
                vim.api.nvim_input("<cmd>qa<cr>")
              end,
              desc = " Quit", icon = " ", key = "q",
            },
            {
              action = function ()
                vim.api.nvim_input("<cmd>Oil<CR>")
              end,
              desc = " Open File-Buffer", icon = "󰣞", key = "f",
            },

          },
          -- stylua: ignore start
        },
      }
      return opts
    end,
  },
}
