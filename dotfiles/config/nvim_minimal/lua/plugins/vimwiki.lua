return { 
    "vimwiki/vimwiki",

    init = function()
        local list = {}
        list.path = "~/Documents/notes"
        list.syntax = "markdown"
        list.ext = ".md"
        vim.g.vimwiki_list = {
            list,
        }

    end
}
