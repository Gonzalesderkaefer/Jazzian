
-- [[ Basic Keymaps ]]

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
