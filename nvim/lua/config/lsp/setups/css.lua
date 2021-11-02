-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
local css = function(config)
	local opts = { settings = { css = { validate = false } } }
	for k, v in pairs(config) do
		opts[k] = v
	end
	return opts
end

return css
