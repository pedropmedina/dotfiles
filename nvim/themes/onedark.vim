" onedark.vim override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

" Hide ~ after last line on buffer
let g:onedark_hide_endofbuffer=1

" Enable italic comments
let g:onedark_terminal_italics=1

" Enable 256-color mode
let g:onedark_termcolors=256

" Enable syntax highlighting and set colorscheme
" These two settings must be setup after the variables above in order to ensure the correct behavior
syntax on | colorscheme onedark
