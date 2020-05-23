" Disable Netrw in order to use Ranger as an alternative
let g:loaded_netrw= 1
let g:netrw_loaded_netrwPlugin= 1

" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_ex_enable = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_pick_enable = 1

" Disable a border for floating window
let g:rnvimr_draw_border = 1

" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_bw_enable = 1

" Set up only two columns in miller mode and draw border with separators
 let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1" --cmd="set draw_borders both"'

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine

" nnoremap <silent> <M-o> :RnvimrToggle<CR>
" tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
" nmap <space>r :RnvimrToggle<CR>

" Resize floating window by all preset layouts
" tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>

" Resize floating window by special preset layouts
" tnoremap <silent> <M-l> <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>

" Resize floating window by single preset layout
" tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>

let g:rnvimr_presets = [{'width': 0.800, 'height': 0.800}]

"  " Customize the initial layout
"  let g:rnvimr_layout = { 'relative': 'editor',
"              \ 'width': float2nr(round(0.6 * &columns)),
"              \ 'height': float2nr(round(0.6 * &lines)),
"              \ 'col': float2nr(round(0.2 * &columns)),
"              \ 'row': float2nr(round(0.2 * &lines)),
"              \ 'style': 'minimal' }

" Customize multiple preset layouts
" '{}' represents the initial layout
"   let g:rnvimr_presets = [
"               \ {},
"               \ {'width': 0.700, 'height': 0.700},
"               \ {'width': 0.800, 'height': 0.800},
"               \ {'width': 0.950, 'height': 0.950},
"               \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0},
"               \ {'width': 0.500, 'height': 0.500, 'col': 0, 'row': 0.5},
"               \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0},
"               \ {'width': 0.500, 'height': 0.500, 'col': 0.5, 'row': 0.5},
"               \ {'width': 0.500, 'height': 1.000, 'col': 0, 'row': 0},
"               \ {'width': 0.500, 'height': 1.000, 'col': 0.5, 'row': 0},
"               \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0},
"               \ {'width': 1.000, 'height': 0.500, 'col': 0, 'row': 0.5}]
