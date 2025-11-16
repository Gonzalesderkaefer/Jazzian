
-- Basic Keymaps

-- Escape to unhighlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next,{ desc = '[d]iagnostic message [n]ext' })
vim.keymap.set("n", "<leader>dm", vim.diagnostic.open_float,{ desc = '[d]iagnostic [m]essage' })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev,{ desc = '[d]iagnostic message [p]previous' })

-- Buffer management
vim.keymap.set("n", "<leader>nn", vim.cmd.bn, { desc = 'Next Buffer'})
vim.keymap.set("n", "<leader>NN", vim.cmd.bprevious, { desc = 'Previous Buffer'})
vim.keymap.set("n", "<leader>qq", vim.cmd.bdelete, { desc = 'Close Buffer'})

-- Splits
vim.keymap.set("n", "<leader>sv", vim.cmd.vnew,{ desc = '[s]plit [v]ertical '})
vim.keymap.set("n", "<leader>sh", vim.cmd.new,{ desc = '[s]plit [h]orizontal '})
vim.keymap.set("n", "<leader>se", "<C-w>=",{ desc = '[s]plit [e]qual '})
vim.keymap.set("n", "<leader>sx", vim.cmd.close,{ desc = 'close split'})


-- LSP Keybinds
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" }, { "n", "x" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "dm", vim.diagnostic.open_float, { desc = "LSP: [D]iagnostic [M]essage" })


-- Command key
vim.keymap.set("n", "<leader>x", ":term ", { desc = "Enter command" })

-- Close quickfix list
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { desc = "Close Quickfix" })
vim.keymap.set("n", "<C-n>", ":cnext<CR>", { desc = "Close Quickfix" })
vim.keymap.set("n", "<C-p>", ":cprev<CR>", { desc = "Close Quickfix" })

-- Close loclist
vim.keymap.set("n", "<leader>lc", ":cclose<CR>", { desc = "Close Quickfix" })
