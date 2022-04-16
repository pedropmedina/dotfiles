-- https://github.com/sumneko/lua-language-server
local lua = function(config)
	local opts = {
		settings = {
			Lua = {
				format = { enable = false },
				runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
				diagnostics = { enable = true, globals = { "vim", "use", "cmp", "packer_plugins" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
			},
		},
	}
	for k, v in pairs(config) do
		if k == "on_attach" then
			opts[k] = function(client)
				client.resolved_capabilities.document_formatting = false
				v(client)
			end
		else
			opts[k] = v
		end
	end
	return opts
end

return lua
