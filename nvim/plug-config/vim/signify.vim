" Git gutter signs
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'

" I find the numbers disctracting
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1


" ----------------------------- Plugin specific mappings -----------------------------

nmap <leader>sgj <plug>(signify-next-hunk)
nmap <leader>sgk <plug>(signify-prev-hunk)
nmap <leader>sgJ 9999<leader>gJ
nmap <leader>sgK 9999<leader>gk
