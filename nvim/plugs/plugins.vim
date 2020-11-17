" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
" Themes
Plug 'joshdick/onedark.vim'

" Status line
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Better experience when working with Neovim builtin lsp support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Syntax highlight and more
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" handlebars file support - treesitter does not support file type yet
Plug 'mustache/vim-mustache-handlebars'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" File explorer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'

" Change pwd to project's root
Plug 'airblade/vim-rooter'

" Formatters
Plug 'sbdchd/neoformat'

" Comment out code
Plug 'tomtom/tcomment_vim'

" Surround text
Plug 'tpope/vim-surround'

" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'

" Colorize matching parentheses
Plug 'junegunn/rainbow_parentheses.vim'

" Automatically rename matching tags
Plug 'AndrewRadev/tagalong.vim'

" Automatically clear highlight ( :nohls )
Plug 'haya14busa/is.vim'

" Search highlighted text with * or # from a visual block
Plug 'nelstrom/vim-visual-star-search'
call plug#end()
