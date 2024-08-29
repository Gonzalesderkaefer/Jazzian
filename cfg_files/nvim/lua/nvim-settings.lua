--Setting tab to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4

-- Setting space to leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable relative Numberlines
vim.opt.relativenumber = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Enable current line highlighting
vim.opt.cursorline = true

-- Split down and right by default
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Exit terminal by hitting ESC twice
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10


-- Keybinds
vim.keymap.set("n", "<C-i>", ":BufferNext<CR>")
vim.keymap.set("n", "<C-W>", ":w | BufferClose<CR>")
vim.keymap.set("n", "<leader>f", ":Explore<CR>")
vim.keymap.set("n", "<F12>", ":20 split | terminal<CR>")

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Binding y to yank into +
vim.cmd("set clipboard+=unnamedplus")

