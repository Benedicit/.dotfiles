local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.keymap.set

-- NOTE: Normal mode bindings
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

keymap("n", "<leader>vs", ":vsplit<CR>", opts)
keymap("n", "<leader>sp", ":split<CR>", opts)
-- Enter terminal
keymap("n", "<leader>vt", ":vsplit<CR>:terminal<CR>", opts)
-- Exit terminal mode in the builtin terminal
keymap("t", "<S-Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- NOTE: Keymaps specific for some programming languages
keymap("n", "<leader>py", ":vsplit<CR>:terminal python3 %<CR>", opts) -- Execute current python file in a seperate NeoVim window
keymap("n", "<leader>ut", ":vsplit<CR>:terminal utop<CR>", opts)
keymap("n", "<leader>dn", ":vsplit<CR>:terminal dune build<CR>")
-- Disable arrow keys in normal mode
keymap("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
keymap("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
keymap("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
keymap("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- CTRL+<hjkl> to switch between windows
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize windows windows with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", { desc = "Expand window upwards" })
keymap("n", "<C-Down>", ":resize +2<CR>", { desc = "Expand window downwards" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Expand window to the left" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Expand window to the right" })

-- Navigate Buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Nvim Tree Keybindings
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Mapping for the Markdown plugins
keymap("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", opts)
keymap("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", opts)

keymap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- NOTE: Visual mode bindings

-- Keep indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<M-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- NOTE: Terminal mode bindings

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
--[[
local neoscroll = require("neoscroll")
-- stylua: ignore start
local neoscroll_keys = {
  -- Use the "sine" easing function
  ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250; easing = 'sine' }) end;
  ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250; easing = 'sine' }) end;
  -- Use the "circular" easing function
  ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450; easing = 'circular' }) end;
  ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450; easing = 'circular' }) end;
  -- When no value is passed the `easing` option supplied in `setup()` is used
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
  ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
}
-- stylua: ignore end
local modes = { "n", "v", "x" }
for key, func in pairs(neoscroll_keys) do
  keymap(modes, key, func)
end
--]]
