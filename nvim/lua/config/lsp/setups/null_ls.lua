return function(config)
    local null_ls = require("null-ls")
	null_ls.config({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.diagnostics.eslint,
		},
	})

	require("lspconfig")["null-ls"].setup(config)
end
