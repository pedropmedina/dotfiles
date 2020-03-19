  set nocompatible                " not compatible with Vi
  filetype plugin indent on       " mandatory for modern plugins
  syntax on                       " enable syntax highlighting
  set autoindent                  " copy indent from the previous line
  set autoread                    " reload from disk
  set backspace=indent,eol,start  " modern backspace behavior
  set belloff=all                 " disable the bell
  set cscopeverbose               " verbose cscope output
  set complete-=i                 " don't scan current on included
                                  " files for completion
  set directory=$HOME/.vim/swap// " Place .swp files in this dir instead of working dir
  set display=lastline            " display more message text
  set encoding=UTF-8              " set default encoding
  set fillchars=vert:│,fold:·     " separator characters
  set formatoptions=tcqj          " more intuitive autoformatting
  set fsync                       " call fsync() for robust file saving
  set history=10000               " longest possible command history
  set hlsearch                    " highlight search results
  set incsearch                   " move cursor as you type when searching
  set langnoremap                 " helps avoid mappings breaking
  set laststatus=2                " always display a status line
  set listchars=tab:>\ ,trail:-,nbsp:+  " chars for :list
  set nrformats=bin,hex           " <c-a> and <c-x> support
  set ruler                       " display current line # in a corner
  set sessionoptions-=options     " do not carry options across sessions
  set shortmess=F                 " less verbose file info
  set showcmd                     " show last command in the status line
  set sidescroll=1                " smoother sideways scrolling
  set smarttab                    " tab setting aware <Tab> key
  set tabpagemax=50               " maximum number of tabs open by -p flag
  set tags=./tags;,tags           " filenames to look for the tag command
  set ttimeoutlen=50              " ms to wait for next key in a sequence
  set ttyfast                     " indicates that our connection is fast
  set viminfo+=!                  " save global variables across sessions
  set wildmenu                    " enhanced command line completion
  set clipboard=unnamed           " Yank and paste with the system clipboard
  set fillchars+=vert:.           " Change vertical split character to be a space (essentially hide it)
  set splitbelow                  " Set preview window to appear at bottom
  set mouse=a                     " Enable mouse support in all modes
  set scrolloff=5                 " Set scrolloff.
  set number                      " Turn on line numbering.
  set relativenumber              " Set row numbers relative cursor's position
  set completeopt-=preview        " keep preview window closed
  set ignorecase
  set smartcase
  set nowrap                      " Stop text from wrapping when reach end of monitor
  set linebreak                   " Prevents words from split up in two lines when set wrap
  set smartindent                 " Set smart indent
  set textwidth=88                " Break lines when line length increases
  set expandtab                   " Enter spaces when tab is pressed
  set tabstop=2                   " Use 2 spaces to represent tab
  set softtabstop=2
  set shiftwidth=2                " Number of spaces to use for auto indent
  set termguicolors              " Enable true colors support


" Exit terminal mode with Esc ===
tnoremap <Esc> <C-\><C-n>

" Use CTRL-{h,j,k,l} to navigate windows from any mode
tnoremap <C-h> <C-\><C-N><C-w><C-h>
tnoremap <C-j> <C-\><C-N><C-w><C-j> 
tnoremap <C-k> <C-\><C-N><C-w><C-k>
tnoremap <C-l> <C-\><C-N><C-w><C-l> 
inoremap <C-h> <C-\><C-N><C-w><C-h>
inoremap <C-j> <C-\><C-N><C-w><C-j> 
inoremap <C-k> <C-\><C-N><C-w><C-k> 
inoremap <C-l> <C-\><C-N><C-w><C-l> 
nnoremap <C-h> <C-w><C-h> 
nnoremap <C-j> <C-w><C-j> 
nnoremap <C-k> <C-w><C-k> 
nnoremap <C-l> <C-w><C-l>
