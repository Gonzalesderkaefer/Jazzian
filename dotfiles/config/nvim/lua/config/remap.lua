-- Basic Keymaps

-- Escape to unhighlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next,{ desc = '[d]iagnostic message [n]ext' })
vim.keymap.set("n", "dm", vim.diagnostic.open_float,{ desc = '[d]iagnostic [m]essage' })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev,{ desc = '[d]iagnostic message [p]previous' })

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

-- Command key
vim.keymap.set("n", "<leader>x", ":term ", { desc = "Enter command" })

-- quickfix list bindings
vim.api.nvim_create_autocmd('FileType', {
    pattern = {"qf"},
    callback = function(env)
        vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { buffer = true, desc = "[C]lose Quickfix" })
        vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true,  desc = "Quickfix [P]rev" })
        vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR><cmd>wincmd j<CR>", { buffer = true,  desc = "Quickfix [N]ext" })
        vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR><cmd>wincmd j<CR>", { buffer = true,  desc = "Quickfix [N]ext" })
    end,
})
