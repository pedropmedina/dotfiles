local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- required to ensure lsp completion :h lsp-buf
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- common keymap options
    local opts = { noremap = true, silent = true }

    -- diagnostics keymaps
    buf_set_keymap('n', '<Leader>dl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<Leader>dk', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<Leader>dj', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<Leader>do', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- conditinally set LSP keymappings depending on capabilities
    if client.resolved_capabilities.type_definition then
        buf_set_keymap('n', '<Leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    end
    if client.resolved_capabilities.signature_help then
        buf_set_keymap('n', '<Leader>gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    end
    if client.resolved_capabilities.implementation then
        buf_set_keymap('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    end
    if client.resolved_capabilities.code_action then
        buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end
    if client.resolved_capabilities.range_code_action then
        buf_set_keymap('x', '<Leader>ca', '<cmd>\'<\'>lua vim.lsp.buf.range_code_action()<CR>', opts)
    end
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
        vim.cmd [[augroup END]]

        buf_set_keymap('n', '<Leader>gf', '<cmd>lua formatting()<CR>', opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap('n', '<Leader>gf', '<cmd>lua formatting()<CR>', opts)
    end
    if client.resolved_capabilities.goto_definition then
        buf_set_keymap('n', '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    end
    if client.resolved_capabilities.hover then
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<Leader>gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end
    if client.resolved_capabilities.find_references then
        buf_set_keymap('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    end
    if client.resolved_capabilities.rename then
        buf_set_keymap('n', '<Leader>grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    end
end

-- Enable (broadcasting) snippet capability for [html, css] completion - No sure if this will be needed in the future
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return { on_attach = on_attach, capabilities = capabilities }
