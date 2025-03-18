
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


-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })





-- LSP Keybinds
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" }, { "n", "x" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "dm", vim.diagnostic.open_float, { desc = "LSP: [D]iagnostic [M]essage" })
