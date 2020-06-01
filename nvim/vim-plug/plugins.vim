" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Comment out code
    Plug 'tpope/vim-commentary'

    " Surround text
    Plug 'tpope/vim-surround'

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " Auto pairs for '(' '[' '{' 
    Plug 'jiangmiao/auto-pairs'

    " Colorize matching parentheses
    Plug 'junegunn/rainbow_parentheses.vim'

    " Themes
    Plug 'joshdick/onedark.vim'

    " Stable version of coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

    " Fuzzy search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'

    " Start screen
    Plug 'mhinz/vim-startify'

    " Git integration
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'

    " Easy move around file
    Plug 'justinmk/vim-sneak'

    " Remember key bindings
    Plug 'liuchengxu/vim-which-key'

    " Automatically clear highlight ( :nohls )
    Plug 'haya14busa/is.vim'

    " Search highlighted text with * or # from a visual block
    Plug 'nelstrom/vim-visual-star-search'

    " Multiple files find and replace
    Plug 'brooth/far.vim'
call plug#end()
