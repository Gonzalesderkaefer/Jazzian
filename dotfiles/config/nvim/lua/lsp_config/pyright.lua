vim.api.nvim_create_autocmd('FileType', {
    -- This handler will fire when the buffer's 'filetype' is "python"
    pattern = {'python'},
    callback = function()
        vim.lsp.start({
            name = 'pyright',
            cmd = { "pyright-langserver", "--stdio" },
    })
end,
})
