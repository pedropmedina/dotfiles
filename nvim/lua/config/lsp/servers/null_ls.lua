local present, null_ls = pcall(require, "null-ls")

return function(config)
	if present then
		local null_config = {
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.eslint,
			},
		}

		for key, value in pairs(config) do
			null_config[key] = value
		end

		null_ls.setup(null_config)
	end
end
