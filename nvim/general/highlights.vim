" Enable italic comments
hi Comment cterm=italic

" Transparent background for the line numbers column
hi LineNr ctermbg=NONE guibg=NONE

" Lsp diagnostics
sign define LspDiagnosticsSignError text=• texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=• texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=• texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=• texthl=LspDiagnosticsSignHint linehl= numhl=
