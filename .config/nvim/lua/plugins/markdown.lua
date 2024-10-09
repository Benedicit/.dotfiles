return {
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      local render_markdown = require("render-markdown")
      render_markdown.setup({
        enabled = false,
      })
    end,
  },
}
