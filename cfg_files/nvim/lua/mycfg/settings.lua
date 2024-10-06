--Setting tab to 4 spaces
vim.opt.tabstop = 8
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.bo.softtabstop = 4

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


-- Binding y to yank into +
vim.cmd("set clipboard+=unnamedplus")

