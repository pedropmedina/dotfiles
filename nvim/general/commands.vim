" Dont' add comment prefix when hitting Enter or o/O on comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
autocmd! BufWritePost $MYVIMRC source %

" Hide the status bar when opening fzf
autocmd! FileType fzf set laststatus=0 noruler nonumber norelativenumber
      \| autocmd BufLeave <buffer> set laststatus=2 ruler number relativenumber

" Remove number column from terminal emulator window
augroup cleanup_terminal
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * set nonumber norelativenumber
augroup END
