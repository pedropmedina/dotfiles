set encoding=utf-8                        " The encoding displayed
set fileencoding=utf-8                    " The encoding written to file
set t_Co=256                              " Support 256 colors
set termguicolors                         " Enables 24-bit RGB color
set background=dark                       " tell vim what the background color looks like
set guifont=Victor\ Mono                  " Font family
set number                                " Line numbers
set relativenumber                        " Set number relative to the cursor
set ruler                                 " Show the cursor position all the time
set cursorline                            " Enable highlighting of the current line
set laststatus=2                          " Always display the status line
set showtabline=2                         " Always show tabs
set signcolumn=yes                        " Always show the signcolumn, otherwise it would shift the text each time
set pumheight=15                          " Makes popup menu smaller
set splitbelow                            " Horizontal splits will automatically be below
set splitright                            " Vertical splits will automatically be to the right
set iskeyword+=-                          " treat dash separated words as a word text object"
set formatoptions-=cro                    " Stop newline continution of comments
set hidden                                " Required to keep multiple buffers open multiple buffers
set nowrap                                " Display long lines as just one line
set cmdheight=1                           " More space for displaying messages
set mouse=a                               " Enable your mouse
set conceallevel=0                        " So that I can see `` in markdown files
set tabstop=2                             " Insert 2 spaces for a tab
set shiftwidth=2                          " Change the number of space characters inserted for indentation
set smarttab                              " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                             " Converts tabs to spaces
set smartindent                           " Makes indenting smart
set autoindent                            " Good auto indent
set noshowmode                            " Hide mode -- INSERT --, ...
set nobackup                              " This is recommended by coc
set nowritebackup                         " This is recommended by coc
set updatetime=300                        " Faster completion
set timeoutlen=500                        " By default timeoutlen is 1000 ms
set ttimeoutlen=0                         " By default timeoutlen is 1000 ms
set clipboard=unnamedplus                 " Copy paste between vim and everything else
set ignorecase                            " Case insensitive search
set incsearch                             " Show search pattern as type
set completeopt=menuone,noinsert,noselect " Improve completion experience
set shortmess+=c                          " Don't pass messages to |ins-completion-menu|.
set autowriteall                          " Save file on buffer change
" set colorcolumn=100                     " Show delimeter line at 100th column
" set foldcolumn=2                        " Folding abilities
