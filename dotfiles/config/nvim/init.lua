-- Set leader to space
vim.g.mapleader = ' '
vim.maplocalleader = ' '

-- Tabbing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- CTRL-V Tab to insert real tab


-- Nerdfont exists
vim.g.have_nerd_font = true


-- Enable number lines
vim.opt.number = true

-- clipboard between OS and nvim is synced
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Make line wraps vertically aligned
vim.opt.breakindent = true


-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- How to display certain characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- substitutions while typing
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- linelength indicator
vim.opt.colorcolumn = "80"


-- Set key timeout
vim.opt.timeoutlen = 2000


-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Turn on virtual text
vim.diagnostic.config({ virtual_text = true })

-- Lazy plugin manager in lua/config/lazy.lua
require("config.lazy")

-- Load keybindings
require("config.remap")


-- Highlight LSP-References
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local highlight_group = vim.api.nvim_create_augroup('highlight', { clear = false })
        -- Acutally highlight them
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
        })

        -- 'Unhighlight' them
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
        })

        -- cleanup autocmds
        vim.api.nvim_create_autocmd('LspDetach', {
          callback = function(other_event)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'highlight', buffer = other_event.buf }
          end,
        })

    end,
})




