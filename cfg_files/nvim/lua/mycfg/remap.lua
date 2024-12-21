
local v = vim

-- Setting leader to space
v.g.mapleader = " "

-- Configuring telescope
v.keymap.set("n", "<leader>ff", function () v.cmd.Telescope("find_files") end)
v.keymap.set('n', '<leader>fb', ":Telescope buffers<CR>", { desc = 'Telescope buffers' })


-- Defocus terminal by hitting ESC twice
v.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Oil
v.keymap.set("n", "<leader>pv", v.cmd.Oil)

-- Launch Terminal 
v.keymap.set("n", "<F12>", function ()
    v.cmd.vnew()
    v.cmd.term()
    v.cmd.wincmd("J")
    v.api.nvim_win_set_height(0,20)
end)

-- Clear search
v.keymap.set("n", "<leader>nh", v.cmd.nohlsearch)


-- Window navigation
v.keymap.set("n", "<c-k>", "<C-W>k")
v.keymap.set("n", "<c-j>", "<C-W>j")
v.keymap.set("n", "<c-h>", "<C-W>h")
v.keymap.set("n", "<c-l>", "<C-W>l")


-- Splits
v.keymap.set("n", "<leader>sv", v.cmd.vnew)
v.keymap.set("n", "<leader>sh", v.cmd.new)
v.keymap.set("n", "<leader>se", "<C-w>=")
v.keymap.set("n", "<leader>sx", v.cmd.close)


-- Buffer navigation
v.keymap.set("n", "<leader>bn", v.cmd.bn)
v.keymap.set("n", "<leader>bp", v.cmd.bprevious)
v.keymap.set("n", "<C-q>", v.cmd.bdelete)
v.keymap.set("n", "<C-t>", function () v.cmd.Telescope("find_files") end)

-- Pasting without losing initially yanked string
v.keymap.set("x", "<leader>p", "\"_dP")
