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

-- Prettier initial configs
local format_options_prettier = {
    tabWidth = 2,
    singleQuote = true,
    trailingComma = 'all',
    configPrecedence = 'prefer-file',
    noBracketSpacing = false,
    noSemi = false,
    printWidth = 100
}

-- Set init configs under _G for supported file types
-- We'll pass them in to the vim.lsp.buf.formatting() function if NOT disabled
vim.g.format_options_typescript = format_options_prettier
vim.g.format_options_javascript = format_options_prettier
vim.g.format_options_typescriptreact = format_options_prettier
vim.g.format_options_javascriptreact = format_options_prettier
vim.g.format_options_json = format_options_prettier
vim.g.format_options_css = format_options_prettier
vim.g.format_options_scss = format_options_prettier
vim.g.format_options_html = format_options_prettier
vim.g.format_options_yaml = format_options_prettier
vim.g.format_options_markdown = format_options_prettier
vim.g.format_options_vue = format_options_prettier

-- Helper function to toggle formatting on and off based off file type
FormatToggle = function(value)
    vim.g[string.format('format_disabled_%s', vim.bo.filetype)] = value
end

-- Command available to enable/disable formatting per file type
vim.cmd([[command! FormatDisable lua FormatToggle(true)]])
vim.cmd([[command! FormatEnable lua FormatToggle(false)]])

-- Global function we call on BufWritePost to format file type
_G.formatting = function()
    if not vim.g[string.format('format_disabled_%s', vim.bo.filetype)] then
        vim.lsp.buf.formatting(vim.g[string.format('format_options_%s', vim.bo.filetype)] or {})
    end
end
