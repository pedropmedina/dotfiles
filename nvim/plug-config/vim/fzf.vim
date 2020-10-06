" Default extra key bindings
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Empty value to disable preview window altogether
let g:fzf_preview_window = ''

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Window size and position
" let g:fzf_layout = {  'window': { 'width': 0.9, 'height': 0.9, 'yoffset':0.5, 'xoffset': 0.5, 'border': 'sharp', 'highlight': 'Todo' } }
let g:fzf_layout = {  'down': '~45%' }

" Default fzf preview options used across all commands
let fzf_preview_default_options = ['--layout=reverse', '--margin=1,1', '--info=inline', '--ansi', '--preview-window=right:60%:hidden:wrap']

" Customize fzf colors to match color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'gutter':  ['fg', 'EndOfBuffer'],
      \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': fzf_preview_default_options}), <bang>0)

" Get text in files with Rg
command! -nargs=* -bang  Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview({ 'options': ['--delimiter=:', '--nth=4..'] + fzf_preview_default_options })
      \           : fzf#vim#with_preview({ 'options': ['--delimiter=:', '--nth=4..'] + fzf_preview_default_options }),
      \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen, preview_opts)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = { 'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command] + a:preview_opts }
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -bang -nargs=* RG call RipgrepFzf(<q-args>, <bang>0, fzf_preview_default_options)

"Get Buffers
command -bang -nargs=* Buffers
      \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': fzf_preview_default_options}), <bang>0)

" Git grep
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': fzf_preview_default_options }), <bang>0)

" ----------------------------- Plugin specific mappings -----------------------------

nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :BLines<CR>
nnoremap <Leader>fg :GGrep<CR>
nnoremap <Leader>frg :Rg<CR>
nnoremap <Leader>frG :RG<CR>
