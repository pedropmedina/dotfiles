" ---------------------------------------------------------------------
"                     - Imports -
" ---------------------------------------------------------------------
lua require('general')
lua require('plugins')

" ---------------------------------------------------------------------
"                     - Non-Specific Settings -
" ---------------------------------------------------------------------
" Remove number column from terminal emulator window
augroup cleanup_terminal
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * set nonumber norelativenumber
augroup END

" highlight on yank
autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup="IncSearch", timeout=400 })

" auto save buffer on leaving
let save_excluded = ['lua.luapad']
autocmd BufLeave * if index(save_excluded, &ft) == -1 | silent! update | endif
