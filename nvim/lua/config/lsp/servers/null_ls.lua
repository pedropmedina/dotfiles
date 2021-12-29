return function(config)
	local setup = require("null-ls").setup
	local builtins = require("null-ls").builtins

	local null_config = {
		sources = {
			builtins.formatting.stylua,
			builtins.formatting.prettier,
			builtins.diagnostics.eslint,
		},
	}

	for key, value in pairs(config) do
		null_config[key] = value
	end

	setup(null_config)
end
