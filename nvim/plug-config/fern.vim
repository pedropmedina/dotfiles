" Disable netrw
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

let g:fern#disable_default_mappings = 1


" Custom mappings
function! FernInit() abort
	" Perform 'open' on leaf node and 'enter' on branch node
	nmap <buffer><expr>
	      \ <Plug>(fern-open-or-enter)
	      \ fern#smart#leaf(
	      \   "\<Plug>(fern-action-open:select)",
	      \   "\<Plug>(fern-action-expand)",
	      \ )
  nmap <buffer> R <Plug>(fern-action-rename)
	nmap <buffer> M <Plug>(fern-action-move)
	nmap <buffer> C <Plug>(fern-action-copy)
	nmap <buffer> N <Plug>(fern-action-new-path)
	nmap <buffer> F <Plug>(fern-action-new-file)
	nmap <buffer> D <Plug>(fern-action-new-dir)
  nmap <buffer> S <Plug>(fern-action-open:split)
  nmap <buffer> V <Plug>(fern-action-open:vsplit)
  nmap <buffer> rl <Plug>(fern-action-reload)
	nmap <buffer> dd <Plug>(fern-action-trash)
  nmap <buffer> <leader> <Plug>(fern-action-mark:toggle)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> l <Plug>(fern-open-or-enter)
  nmap <buffer><nowait> H <Plug>(fern-action-leave)
  nmap <buffer><nowait> L <Plug>(fern-action-enter)
  nmap <buffer> ! <Plug>(fern-action-hidden:toggle)
endfunction

" Initiate fern custom mappings and hide number and relativenumber column
augroup FernGroup
  autocm!
  autocmd FileType fern call FernInit() 
augroup END

" Open Fern as drawer and reveal current buffer in the file tree
noremap <silent> <Leader>e :Fern . -drawer -reveal=% -toggle -width=30<CR><C-w>=
