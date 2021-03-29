-- Modify diagnostic's signs, and other... Also add diagnostics to local quick fix list
vim.lsp.handlers['textDocument/publishDiagnostics'] = function(...)
    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        { underline = true, virtual_text = { spacing = 4, prefix = '•' }, signs = true, update_in_insert = false }
    )(...)
    pcall(vim.lsp.diagnostic.set_loclist, { open_loclist = false })
end

-- Disable column text e.g W, H, E and add color to line number
vim.fn.sign_define('LspDiagnosticsSignError', { text = '', numhl = 'LspDiagnosticsDefaultError' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = '', numhl = 'LspDiagnosticsDefaultWarning' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = '', numhl = 'LspDiagnosticsDefaultInformation' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = '', numhl = 'LspDiagnosticsDefaultHint' })
