vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

require("options")
require("keymaps")
require("autocmds")

-- [[ Install `lazy.nvim` plugin manager ]]
--  See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- turn off notifications whenever plugin changes are made
  },
  ui = {
    icons = vim.g.have_nerd_font and {},
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
