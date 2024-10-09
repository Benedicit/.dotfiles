return {
  {
    "kyazdani42/nvim-tree.lua",
    event = "VeryLazy",
    config = function()
      local nvim_tree = require("nvim-tree")

      nvim_tree.setup({
        disable_netrw = true,
        hijack_netrw = true,
        open_on_tab = false,
        hijack_cursor = false,
        update_cwd = true,
        hijack_directories = {
          enable = true,
          auto_open = true,
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = false,
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 500,
        },
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          special_files = { "Cargo.toml", "Makefile", "Dockerfile", "README.md", "readme.md" },
          highlight_git = true,
          root_folder_modifier = ":t",
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
            glyphs = {
              default = "",
              symlink = "",
              git = {
                unstaged = "",
                staged = "",
                unmerged = "",
                renamed = "➜",
                deleted = "",
                untracked = "",
                ignored = "",
              },
              folder = {
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
              },
            },
          },
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      oil.setup({
        columns = { "icon" },
        keymaps = { ["<C-h>"] = false, ["<M-h>"] = "actions.select_split" },
        view_options = {
          show_hidden = true,
        },
        float = {
          preview_split = "below",
          msx_height = 0.5,
        },
      })
      vim.keymap.set("n", "<space>-", oil.toggle_float)
    end,
  },
}
