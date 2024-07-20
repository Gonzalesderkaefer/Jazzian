return {
    'nvim-treesitter/nvim-treesitter', 
    build = ":TSUpdate",
    config = function()
        -- Treesitter configuration
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = {"lua"},
            highlight = {enable = true},
            indent = {enalbe = true},
        })
    end

}
