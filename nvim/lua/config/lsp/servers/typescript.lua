-- https://github.com/theia-ide/typescript-language-server
local function typescript(config)
	local function organize_imports()
		local params = {
			command = "_typescript.organizeImports",
			arguments = { vim.api.nvim_buf_get_name(0) },
			title = "",
		}
		vim.lsp.buf.execute_command(params)
	end

	local opts = {
		commands = { OrganizeImports = { organize_imports, description = "Organize Imports" } },
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

return typescript
