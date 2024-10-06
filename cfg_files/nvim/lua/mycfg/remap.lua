

vim.g.mapleader = " ";
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- Configuring telescope
vim.keymap.set('n', '<leader>ff', ":Telescope find_files<CR>", { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })



-- Exit terminal by hitting ESC twice
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Keybinds
vim.keymap.set("n", "<C-i>", ":BufferNext<CR>")
vim.keymap.set("n", "<C-W>", ":w | BufferClose<CR>")
vim.keymap.set("n", "<leader>f", ":Explore<CR>")
vim.keymap.set("n", "<F12>", ":20 split | terminal<CR>")

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")






