require('trouble').setup(
    {
        height = 20,
        icons = false,
        fold_open = '-',
        fold_closed = '+',
        signs = { error = '•', warning = '•', hint = '•', information = '•', other = '•' },
        use_lsp_diagnostic_signs = false
    }
)
