return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "" },
      change = { text = "~" },
      delete = { text = "" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
}
