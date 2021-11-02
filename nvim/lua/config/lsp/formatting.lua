local format_disabled_var = function()
	return string.format("format_disabled_%s", vim.bo.filetype)
end

-- Toggle formatting on and off based off file type
FormatToggle = function(value)
	vim.g[format_disabled_var()] = value
end

-- Command to enable/disable formatting per file type
vim.cmd([[command! FormatDisable lua FormatToggle(true)]])
vim.cmd([[command! FormatEnable lua FormatToggle(false)]])

-- Format function we call on BufWritePost to format file type
local format = function()
	if not vim.b.saving_format and not vim.g[format_disabled_var()] then
		vim.b.init_changedtick = vim.b.changedtick
		vim.lsp.buf.formatting({})
	end
end

return format
