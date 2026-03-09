return
{
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then return end
                local ok, query = pcall(vim.treesitter.query.get, lang, "highlights")
                if ok and query then
                    vim.treesitter.start()
                else
                    vim.cmd("TSInstall " .. lang)
                end
            end,
        })
    end
}
