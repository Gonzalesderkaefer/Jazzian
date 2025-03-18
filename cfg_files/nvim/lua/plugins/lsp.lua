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
}
