" Matching strategies
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Case insensitive matching
let g:completion_matching_ignore_case = 1

" No need to have a key associated to confirm completion. We use <CR> instead
let g:completion_confirm_key = ""

" Show completion popup on delete
let g:completion_trigger_on_delete = 1

" Don't open the completion popup on keywords less than 1
let g:completion_trigger_keyword_length = 1

" Some extra trigger characters
let g:completion_trigger_character = ['.', '::']

" Timer controls the rate of completion.
let g:completion_timer_cycle = 80

" Do not open detail floating window while navigating completion items
let g:completion_enable_auto_hover = 0

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" ----------------------------- Plugin specific mappings -----------------------------

" Confirm completion completion with <CR>
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
      \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

" Use <Tab>, <S-Tab>, j, k to navigate through popup menu
" inoremap <silent> <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <silent> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent> <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <silent> <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-p> <c-n> to trigger completion in insert mode.
imap <silent> <c-p> <Plug>(completion_trigger)
imap <silent> <c-n> <Plug>(completion_trigger)

" GOTO mappings
nnoremap <silent> <S-K> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader><c-]> <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>gt    <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>gf    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <leader>gw    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>gr    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>gl    <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> <leader>ga    <cmd>lua vim.lsp.buf.code_action()<CR>
