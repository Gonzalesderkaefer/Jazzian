return {
    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- This is mostly the default config for clangd
            require("lspconfig").clangd.setup {}
            require("lspconfig").rust_analyzer.setup {}
        end,
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
            require("mason-lspconfig").setup()

            -- Setup LSPs installed from Mason automatically
            -- require("mason-lspconfig").setup_handlers {
            --     function (server_name) -- default handler (optional)
            --         require("lspconfig")[server_name].setup {}
            --     end,
            -- }
        end,
    },
}
