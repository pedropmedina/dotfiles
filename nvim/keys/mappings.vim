" g Leader key
let mapleader=" "

" let localleader=" "
nnoremap <Space> <Nop>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Find and Replace word under the cursor
nnoremap <Leader>fr :%s///g<Left><Left>

" Find and Replace selected words in visual mode
xnoremap <Leader>fr :s///g<Left><Left>

" Multiple cursors alternative. Under a word or selection replace word and repeat instance with '.'
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Search for word under the cursor within the project
nnoremap <Leader>gr :CocSearch <C-R>=expand("<cword>")<CR><CR>

" Save and quit files
nnoremap <Leader>w  :w!<CR>
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>wq :wq<CR>

" Current window split horizontally, vertically, equal size
nnoremap <Leader>_ <C-w>s
nnoremap <Leader>\| <C-w>v
nnoremap <Leader>= <C-w>=

" Normal mode window navigation
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

" Terminal window navigation - ( ignore fzf file )
tnoremap <expr> <Esc> (&filetype == "fzf") ?  "<Esc>" : "<C-\><C-N>"
tnoremap <expr> <C-h> (&filetype == "fzf") ?  "<C-h>" : "<C-\><C-N><C-w>h"
tnoremap <expr> <C-j> (&filetype == "fzf") ?  "<C-j>" : "<C-\><C-N><C-w>j"
tnoremap <expr> <C-k> (&filetype == "fzf") ?  "<C-k>" : "<C-\><C-N><C-w>k"
tnoremap <expr> <C-l> (&filetype == "fzf") ?  "<C-l>" : "<C-\><C-N><C-w>l"
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l

" Buffers navigation
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>
nnoremap <leader>bl :bnext<CR>
nnoremap <leader>bh :bprevious<CR>
nnoremap <leader>bq :bdelete<CR>

" Tabs navigation
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabprevious<CR>
nnoremap <leader>tq :tabclose<CR>

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

" Opening new terminal emulators
nnoremap <leader>tt :tabnew +terminal<CR>
tnoremap <leader>tt <C-b>c <C-\><C-n>:tabnew +terminal<CR>
nnoremap <leader>ts :new +terminal<CR>
tnoremap <leader>ts <C-\><C-n>:new +terminal<CR>
nnoremap <leader>tv :vnew +terminal<CR>
tnoremap <leader>tv <C-\><C-n>:vnew +terminal<CR>
