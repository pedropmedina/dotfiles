" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Formatters
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " Comment out code
    Plug 'tpope/vim-commentary'

    " Surround text
    Plug 'tpope/vim-surround'

    " Better Syntax Support
    Plug 'nvim-treesitter/nvim-treesitter'

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

    " File explorer
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug 'lambdalisue/fern-hijack.vim'

    " Prisma 2 highlight support
    Plug 'pantharshit00/vim-prisma'

    " Stable version of coc - KEEP IT FOR NOW TO ACCESS LSP THAT AREN'T AVAILABLE IN NEOVIM YET
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Neovim lsp Plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-lua/diagnostic-nvim'

    " Fuzzy search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Change working directory to project root
    " Specially useful when fuzzy searching within a subdir as it'll show all files instead of only the ones at the subdir
    Plug 'airblade/vim-rooter'

    " Git integration
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
call plug#end()
