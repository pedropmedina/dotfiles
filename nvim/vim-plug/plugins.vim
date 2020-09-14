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

    " Automatically rename matching tags
    Plug 'AndrewRadev/tagalong.vim'

    " Automatically clear highlight ( :nohls )
    Plug 'haya14busa/is.vim'

    " Search highlighted text with * or # from a visual block
    Plug 'nelstrom/vim-visual-star-search'

    " Colorize matching parentheses
    Plug 'junegunn/rainbow_parentheses.vim'

    " Themes
    Plug 'joshdick/onedark.vim'

    " Status line
    Plug 'vim-airline/vim-airline'

    " Prisma 2 highlight support
    Plug 'pantharshit00/vim-prisma'

    " Stable version of coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Fuzzy search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Change working directory to project root
    " Specially useful when fuzzy searching within a subdir as it'll show all files instead of only the ones at the subdir
    Plug 'airblade/vim-rooter'

    " Git integration
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'

    " Snippets
    Plug 'honza/vim-snippets'
call plug#end()
