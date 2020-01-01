"   => vim's setup --------------------------------------------------------{{{1
"   Note: This configs are defaults to nvim, so we only set them up if using vim

if !has('nvim')
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
endif

"   => Providers' path ----------------------------------------------------{{{1
"   Note: needed in order to support remote-plugins in (python, node, ruby)

let g:python_host_prog = "/Users/pedropmedina/nvimenvs/neovim2/bin/python"
let g:python3_host_prog = "/Users/pedropmedina/nvimenvs/neovim3/bin/python"

"   => Mapped keys ---------------------------------------------------------{{{1

" === Set leader to , key ===
let g:mapleader = "\<Space>"       

" === toggle coc-explorer ===
nmap <leader>e :CocCommand explorer<CR>

" === Toggle undo-tree with f5 ===
noremap <f5> :UndotreeToggle<cr> 

" === Exit terminal mode with Esc ===
tnoremap <Esc> <C-\><C-n>

" === Windows navigation ===
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

" === Suggenstion navigation ===
" Use TAB/SHIFT-TAB to navigate suggestions list and ENTER to select
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap <leader>b :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec -path='.'<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" 🚨 Using coc-explorer instead
" === Nerdtree shorcuts === 
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
" nmap <leader>n :NERDTreeToggle<CR>
" nmap <leader>f :NERDTreeFind<CR>


"   => vim-plug plugins ----------------------------------------------------{{{1

" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
    \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Install plugins required to use denite on both vim and nvim
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' } " Fuzzy finding, buffer management
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

  " Plug 'scrooloose/nerdtree'          " File explorer
  " Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " NERDTree syntax highlight
  " Plug 'Xuyuanp/nerdtree-git-plugin'  " Visualize git changes on nerdtree
  Plug 'ayu-theme/ayu-vim'            " Theme plugin
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
  Plug 'tpope/vim-fugitive'           " Git wrapper
  Plug 'mhinz/vim-signify'            " Visualize git changes on gutter
  Plug 'mbbill/undotree/'             " undo tree 
  Plug 'sheerun/vim-polyglot'         " Syntax and indentation support
  Plug 'vim-airline/vim-airline'      " Status line
  Plug 'vim-airline/vim-airline-themes' "Airline themes collection
  Plug 'terryma/vim-multiple-cursors' " CTR-n to select matching text
  Plug 'Yggdroot/indentLine'          " Indentation lines
  Plug 'tpope/vim-commentary'         " Comment 
  Plug 'tpope/vim-surround'           " Handle surrounding pairs
  Plug 'ryanoasis/vim-devicons'       " Icons

call plug#end()

"   => Custom --------------------------------------------------------------{{{1

" Regenerate tags when saving .py files
au BufWritePost *.py silent! !ctags -R &    

" Load all plugins in .vim/pack/plugins/start.
packloadall                                 

" Load plugins' help files.                                           
silent! helptags ALL                        

set clipboard=unnamed       " Yank and paste with the system clipboard
set fillchars+=vert:.       " Change vertical split character to be a space (essentially hide it)
set splitbelow              " Set preview window to appear at bottom
set mouse=a                 " Enable mouse support in all modes
set scrolloff=5             " Set scrolloff.
set number                  " Turn on line numbering.
set cursorline
set relativenumber          " Set row numbers relative cursor's position
set completeopt-=preview    " keep preview window closed
set ignorecase
set smartcase
set nowrap                  " Stop text from wrapping when reach end of monitor
set linebreak               " Prevents words from split up in two lines when set wrap
set smartindent             " Set smart indent
set textwidth=88            " Break lines when line length increases
set expandtab               " Enter spaces when tab is pressed
set tabstop=2               " Use 2 spaces to represent tab
set softtabstop=2
set shiftwidth=2            " Number of spaces to use for auto indent
set noshowmode              " No need for it. Third party plugin handles this

" Change indentation for python to 4 spaces 
autocmd FileType *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
set foldmethod=marker       " Fold using marker {{{n, where n is fold level

"   => UI --------------------------------------------------{{{1

set termguicolors           " Enable true colors support

set background=dark         " Set background color based on value

let ayucolor = "mirage"     " Set ayu's version theme

colorscheme ayu             " Color scheme to be used by Vim

hi! clear SignColumn        " Remove gutter's background

" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type

" Make background color transparent for git changes
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE

" Highlight git change signs
hi! SignifySignAdd guifg=#99c794
hi! SignifySignDelete guifg=#ec5f67
hi! SignifySignChange guifg=#c594c5

"   => netrw ------------------------------------------------------{{{1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_dirhistmax = 0  " Stop writing to the history file.

 
" => Denite ------------------------------------------------------{{{1
try
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--hidden', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'statusline': 0,
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)


catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry


" => CoC ------------------------------------------------------{{{1
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>x  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" => NERDTree ------------------------------------------------------{{{1
" 🚨 Using coc-explorer instead
" " Show hidden files/directories
" let g:NERDTreeShowHidden = 1

" " Remove bookmarks and help text from NERDTree
" let g:NERDTreeMinimalUI = 1

" " Custom icons for expandable/expanded directories
" let g:NERDTreeDirArrowExpandable = '⬏'
" let g:NERDTreeDirArrowCollapsible = '⬎'

" " Hide certain files and directories from NERDTree
" let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" " Hide the Nerdtree status line to avoid clutter
" let g:NERDTreeStatusline = ''

" " Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" " Disable highlight to improve performace
" let g:NERDTreeHighlightCursorline = 0

" " Tweak syntax highlighting to reduce lag
" let g:NERDTreeDisableExactMatchHighlight = 1
" let g:NERDTreeDisablePatternMatchHighlight = 1
" let g:NERDTreeSyntaxEnabledExtesions = ['html', 'js', 'css', 'ts', 'jsx', 'tsx', 'json', 'py', 'yml' ]


" => NERDTree-git ------------------------------------------------------{{{1
" 🚨 Using coc-explorer instead
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "ᴹ",
"     \ "Staged"    : "ᴬ",
"     \ "Untracked" : "ᵁ",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "ᴰ",
"     \ "Dirty"     : "•",
"     \ "Clean"     : "◦",
"     \ 'Ignored'   : "ⁱ",
"     \ "Unknown"   : "﹖"
"     \ }

" => IndentLine ------------------------------------------------------{{{1
let g:indentLine_char = '·'
" => Airline ------------------------------------------------------{{{1
try

" Enable extensions
let g:airline_extensions = ['branch',  'hunks', 'coc']

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'
 
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
 
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
 
" Configure error/warning section to use coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Disable vim-airline in preview mode
 let g:airline_exclude_preview = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

let g:airline_theme = 'transparent'
 
catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry


" => Misc ------------------------------------------------------{{{1
" Reload icons after init source
" if exists('g:loaded_webdevicons')
"   call webdevicons#refresh()
" endif
