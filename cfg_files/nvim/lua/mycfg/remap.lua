
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


-- Splits
v.keymap.set("n", "<leader>sv", v.cmd.vnew)
v.keymap.set("n", "<leader>sh", v.cmd.new)
v.keymap.set("n", "<leader>se", "<C-w>=")
v.keymap.set("n", "<leader>sx", v.cmd.close)


-- Buffer navigation
v.keymap.set("n", "<leader>nn", v.cmd.bn)
v.keymap.set("n", "<leader>NN", v.cmd.bprevious)
v.keymap.set("n", "<C-q>", v.cmd.bdelete)
v.keymap.set("n", "<C-t>", function () v.cmd.Telescope("find_files") end)

-- Pasting without losing initially yanked string
v.keymap.set("x", "<leader>p", "\"_dP")


-- Move in diagnostics
v.keymap.set("n", "<leader>dn", v.diagnostic.goto_next)
v.keymap.set("n", "<leader>dm", v.diagnostic.open_float)
v.keymap.set("n", "<leader>dn", v.diagnostic.goto_prev)
