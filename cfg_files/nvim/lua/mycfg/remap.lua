

-- Setting leader to space
vim.g.mapleader = " ";

-- Configuring telescope
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', ":Telescope buffers<CR>", { desc = 'Telescope buffers' })


-- Defocus terminal by hitting ESC twice
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Oil
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

-- Netrw
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")

-- Launch Terminal 
vim.keymap.set("n", "<F12>", ":20 split | terminal<CR>")

-- Clear search
vim.keymap.set("n", "<leader>nh<CR>", ":nohlsearch")


-- Window navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Splits
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>h")
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>sx", ":close<CR>")


-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bn<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>bf", ":enew<CR>")
vim.keymap.set("n", "<leader>bdd", ":bdelete!<CR>")



