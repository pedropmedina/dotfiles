-- Save buffer after formatting
vim.lsp.handlers["textDocument/formatting"] = function(err, result, ctx)
	if err ~= nil or result == nil then
		return
	end

	if
		vim.api.nvim_buf_get_var(ctx.bufnr, "init_changedtick") ~= vim.api.nvim_buf_get_var(ctx.bufnr, "changedtick")
	then
		return
	end

	if not vim.api.nvim_buf_get_option(ctx.bufnr, "modified") then
		local view = vim.fn.winsaveview()
		vim.lsp.util.apply_text_edits(result, ctx.bufnr)
		vim.fn.winrestview(view)
		if ctx.bufnr == vim.api.nvim_get_current_buf() then
			vim.b.saving_format = true
			vim.cmd([[update]])
			vim.b.saving_format = false
		end
	end
end

-- Modify diagnostic's signs, and other... Also add diagnostics to local quick fix list
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = { spacing = 4, prefix = "•" },
		signs = true,
		update_in_insert = false,
	})(...)

	pcall(vim.lsp.diagnostic.set_loclist, { open_loclist = false })
end
