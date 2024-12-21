local v = vim

--Setting tab to 4 spaces
v.opt.tabstop = 8
v.opt.shiftwidth = 4
v.opt.expandtab = false
v.bo.softtabstop = 4

-- Enable relative Numberlines
v.opt.relativenumber = true

-- Keep signcolumn on by default
v.opt.signcolumn = "yes"

-- Enable current line highlighting
v.opt.cursorline = true

-- Split down and right by default
v.opt.splitright = true
v.opt.splitbelow = true

-- Exit terminal by hitting ESC twice
v.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Minimal number of screen lines to keep above and below the cursor.
v.opt.scrolloff = 10


-- Binding y to yank into +
v.cmd("set clipboard+=unnamedplus")
