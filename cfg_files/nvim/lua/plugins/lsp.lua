return {
    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()

            -- This is mostly the default config for clangd
            require("lspconfig").clangd.setup {
                capabilities = {
                    offsetEncoding = { "utf-8", "utf-16" },
                    textDocument = {
                        completion = {
                            editsNearCursor = true
                        }
                    }
                },
                cmd = { "clangd" },
                filetypes = { "c", "cc", "h", "hh" },
            }

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
            require("mason-lspconfig").setup_handlers {
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        end,
    },
}
