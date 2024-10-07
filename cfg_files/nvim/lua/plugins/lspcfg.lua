return {

    {
        "neovim/nvim-lspconfig",
	dependencies = {
	    "neovim/nvim-lspconfig",
	    "hrsh7th/cmp-nvim-lsp",
	    "hrsh7th/cmp-buffer",
	    --"hrsh7th/cmp-path",
	    "hrsh7th/cmp-cmdline",
	    "hrsh7th/nvim-cmp",
	    "L3MON4D3/LuaSnip",
	    "saadparwaiz1/cmp_luasnip"
	}

    },


    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
		    "lua_ls",
		    "clangd",
		},
		handlers = {
		    function (server_name)
			--print(server_name)
			require("lspconfig")[server_name].setup {}

		    end
		}
            })
	    local cmp = require("cmp")
	    cmp.setup({
		snippet = {
		    -- REQUIRED - you must specify a snippet engine
		    expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		    end,
		},
		window = {
		    completion = cmp.config.window.bordered(),
		    documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
		    ["<C-n>"] = cmp.mapping.select_next_item(),
		    ["<C-p>"] = cmp.mapping.select_prev_item(),

		    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
		    ["<C-f>"] = cmp.mapping.scroll_docs(4),

		    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
		    ["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
		    { name = 'nvim_lsp' },
		    { name = 'luasnip' },
		    { name = 'buffer' },
		})
	    })
        end
    },

}
