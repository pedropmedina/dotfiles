local preset, cmp = pcall(require, "cmp")

if preset then
	local lspkind = require("lspkind")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")

	cmp.setup({
		completion = { completeopt = "menu,menuone,noinsert" },
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		},
		sources = cmp.config.sources(
			{ { name = "nvim_lsp" }, { name = "luasnip" } },
			{ { name = "path" } },
			{ { name = "buffer", keyword_length = 5 } }
		),
		experimental = { native_menu = false, ghost_text = true },
		formatting = {
			format = lspkind.cmp_format({
				with_text = true,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[lsp]",
					nvim_lua = "[api]",
					path = "[path]",
					luasnip = "[snip]",
				},
			}),
		},
	})

	-- If you want insert `(` after select function or method item
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end
