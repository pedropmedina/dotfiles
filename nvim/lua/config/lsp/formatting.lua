-- save buffer after formatting (Must dig deeper into these functions)
vim.lsp.handlers['textDocument/formatting'] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then vim.cmd [[noautocmd :update]] end
    end
end

-- Helper function to toggle formatting on and off based off file type
FormatToggle = function(value)
    vim.g[string.format('format_disabled_%s', vim.bo.filetype)] = value
end

-- Command available to enable/disable formatting per file type
vim.cmd([[command! FormatDisable lua FormatToggle(true)]])
vim.cmd([[command! FormatEnable lua FormatToggle(false)]])

-- Global function we call on BufWritePost to format file type
_G.formatting = function()
    if not vim.g[string.format('format_disabled_%s', vim.bo.filetype)] then vim.lsp.buf.formatting({}) end
end
