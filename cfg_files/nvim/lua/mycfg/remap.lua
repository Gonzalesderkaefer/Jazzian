
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
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>")


-- Window navigation
vim.keymap.set("n", "<c-k>", "<CMD>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<CMD>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<CMD>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<CMD>wincmd l<CR>")

-- Window navigation (insert mode)
vim.keymap.set("i", "<c-k>", "<CMD>wincmd k<CR>")
vim.keymap.set("i", "<c-j>", "<CMD>wincmd j<CR>")
vim.keymap.set("i", "<c-h>", "<CMD>wincmd h<CR>")
vim.keymap.set("i", "<c-l>", "<CMD>wincmd l<CR>")


-- Splits
vim.keymap.set("n", "<leader>sv", "<CMD>vnew<CR>")
vim.keymap.set("n", "<leader>sh", "<CMD>new<CR>")
vim.keymap.set("n", "<leader>se", "<C-w>=")
vim.keymap.set("n", "<leader>sx", "<CMD>close<CR>")


-- Buffer navigation
vim.keymap.set("n", "<C-Tab>", "<CMD>bn<CR>")
vim.keymap.set("n", "<C-S-Tab>", "<CMD>bprevious<CR>")
vim.keymap.set("n", "<C-q>", "<CMD>bdelete<CR>")
vim.keymap.set("n", "<C-t>", "<CMD>enew | Oil<CR>")



