return {
    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
    },




    -- Mason
    {
        "williamboman/mason.nvim",
    },

    -- Mason lspconfig
    {
        "williamboman/mason-lspconfig.nvim",

        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason").setup()
            -- Setup LSPs installed from Mason automatically
            require("mason-lspconfig").setup {
                function(server_name)
                    --require("lspconfig")[server_name].setup {}
                    vim.lsp.enable(server_name)
                end,

            }
        end,
    },
}
