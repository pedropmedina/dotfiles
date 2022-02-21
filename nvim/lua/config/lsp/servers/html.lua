-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
local html = function(config)
	local opts = {
		filetypes = {
			"html",
			"tsx",
			"jsx",
			"vue",
			"hbs",
			"handlebars",
			"html.hbs",
			"html.handlebars",
			"liquid",
		},
	}
	for k, v in pairs(config) do
		if k == "on_attach" then
			opts[k] = function(client)
				-- TODO: Create list of files we want to enable html server formatting e.g. hbs, liquid
				local filetype = vim.bo.filetype
				if filetype == "vue" then
					client.resolved_capabilities.document_formatting = false
					v(client)
				end
			end
		else
			opts[k] = v
		end
	end
	return opts
end

return html
