let g:diagnostic_enable_virtual_text = 1

let g:diagnostic_insert_delay = 1

let g:diagnostic_virtual_text_prefix = '• '

let g:space_before_virtual_text = 3

let g:diagnostic_auto_popup_while_jump = 0

highlight link LspDiagnosticsError User8

call sign_define("LspDiagnosticsErrorSign", {"text" : "•", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "•", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "•", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "•", "texthl" : "LspDiagnosticsHint"})

" ----------------------------- Plugin specific mappings -----------------------------

nnoremap <silent><leader>] :PrevDiagnostic<CR>
nnoremap <silent><leader>[ :NextDiagnostic<CR>
nnoremap <silent><leader>do :OpenDiagnostic<CR>
