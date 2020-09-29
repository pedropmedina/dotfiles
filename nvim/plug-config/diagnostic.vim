let g:diagnostic_enable_virtual_text = 0

let g:diagnostic_insert_delay = 1

highlight link LspDiagnosticsError User8

call sign_define("LspDiagnosticsErrorSign", {"text" : "•", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "•", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "•", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "•", "texthl" : "LspDiagnosticsHint"})

nnoremap <silent><leader>] :PrevDiagnosticCycle<CR>
nnoremap <silent><leader>[ :NextDiagnosticCycle<CR>
nnoremap <silent><leader>do :OpenDiagnostic<CR>
