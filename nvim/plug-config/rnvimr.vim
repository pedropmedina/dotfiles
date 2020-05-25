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

let g:rnvimr_presets = [{'width': 0.800, 'height': 0.800}]

 " Customize the initial layout
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': float2nr(round(0.8 * &columns)),
            \ 'height': float2nr(round(0.8 * &lines)),
            \ 'col': float2nr(round(0.2 * &columns)),
            \ 'row': float2nr(round(0.2 * &lines)),
            \ 'style': 'minimal' }
