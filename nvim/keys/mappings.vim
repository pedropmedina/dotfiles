" g Leader key
let mapleader=" "
" let localleader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Find and Replace word under the cursor
nnoremap <Leader>fr :%s///g<Left><Left>

" Find and Replace selected words in visual mode
xnoremap <Leader>fr :s///g<Left><Left>

" Multiple cursors alternative. Under a word or selection replace word and repeat instance with '.'
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Search for word under the cursor within the project
nnoremap <Leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

" ESC alternative
inoremap jk <Esc>
inoremap kj <Esc>

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>

" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" <TAB>: completion.
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Save and quit files
nnoremap <Leader>w  :w<CR>
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>wq :wq<CR>

" Current window split horizontally, vertically, equal size
nnoremap <Leader>_ <C-w>s
nnoremap <Leader>\| <C-w>v
nnoremap <Leader>= <C-w>=

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Insert mode navigation
imap <C-h> <Esc><C-w>h
imap <C-j> <Esc><C-w>j
imap <C-k> <Esc><C-w>k
imap <C-l> <Esc><C-w>l
inoremap <C-h> <Esc><C-w>h
inoremap <C-j> <Esc><C-w>j
inoremap <C-k> <Esc><C-w>k
inoremap <C-l> <Esc><C-w>l

" Quit terminal with escape
tnoremap <Esc> <C-\><C-n> :q<CR>

" Terminal window navigation
" tnoremap <C-h> <C-\><C-N><C-w>h
" tnoremap <C-j> <C-\><C-N><C-w>j
" tnoremap <C-k> <C-\><C-N><C-w>k
" tnoremap <C-l> <C-\><C-N><C-w>l
" inoremap <C-h> <C-\><C-N><C-w>h
" inoremap <C-j> <C-\><C-N><C-w>j
" inoremap <C-k> <C-\><C-N><C-w>k
" inoremap <C-l> <C-\><C-N><C-w>l

" Use alt + hjkl to resize windows
" nnoremap <silent> <M-j>    :resize -2<CR>
" nnoremap <silent> <M-k>    :resize +2<CR>
" nnoremap <silent> <M-h>    :vertical resize -2<CR>
" nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Work around for using alt key to resize widows on mac
nnoremap <silent> ˚    :resize -2<CR>
nnoremap <silent> ∆    :resize +2<CR>
nnoremap <silent> ˙    :vertical resize -2<CR>
nnoremap <silent> ¬    :vertical resize +2<CR>


" Toggle Coc explorer
nnoremap <Leader>e :CocCommand explorer<CR>

" FZF
nnoremap <Leader>a :Files<CR>
nnoremap <Leader>t :Rg<CR>
nnoremap <Leader>b :Buffers<CR>

" Floaterm
nnoremap <Leader>lf :FloatermNew lf<CR>
