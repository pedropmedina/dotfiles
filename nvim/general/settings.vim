set iskeyword+=-                          " treat dash separated words as a word text object"
set formatoptions-=cro                    " Stop newline continution of comments
set hidden                                " Required to keep multiple buffers open multiple buffers
set nowrap                                " Display long lines as just one line
set encoding=utf-8                        " The encoding displayed
set pumheight=15                          " Makes popup menu smaller
set fileencoding=utf-8                    " The encoding written to file
set ruler                                 " Show the cursor position all the time
set cmdheight=1                           " More space for displaying messages
set mouse=a                               " Enable your mouse
set splitbelow                            " Horizontal splits will automatically be below
set splitright                            " Vertical splits will automatically be to the right
set t_Co=256                              " Support 256 colors
set conceallevel=0                        " So that I can see `` in markdown files
set tabstop=2                             " Insert 2 spaces for a tab
set shiftwidth=2                          " Change the number of space characters inserted for indentation
set smarttab                              " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                             " Converts tabs to spaces
set smartindent                           " Makes indenting smart
set autoindent                            " Good auto indent
set laststatus=2                          " Always display the status line
set number                                " Line numbers
set relativenumber                        " Set number relative to the cursor
set cursorline                            " Enable highlighting of the current line
set background=dark                       " tell vim what the background color looks like
set showtabline=2                         " Always show tabs
set noshowmode                            " We don't need to see things like -- INSERT -- anymore
set nobackup                              " This is recommended by coc
set nowritebackup                         " This is recommended by coc
set signcolumn=yes                        " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=300                        " Faster completion
set timeoutlen=500                        " By default timeoutlen is 1000 ms
set ttimeoutlen=0                         " By default timeoutlen is 1000 ms
set clipboard=unnamedplus                 " Copy paste between vim and everything else
set ignorecase                            " Case insensitive search
set incsearch                             " Show search pattern as type
set guifont=Victor\ Mono                  " Font family
set autowriteall                          " Save file on buffer change
set termguicolors                         " Enables 24-bit RGB color
set completeopt=menuone,noinsert,noselect " Improve completion experience
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
" set colorcolumn=100                     " Show delimeter line at 100th column
" set foldcolumn=2                        " Folding abilities

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

" You can't stop me
cmap w!! w !sudo tee %
