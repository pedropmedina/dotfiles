let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_session_autoload = 1

let g:startify_session_delete_buffers = 1

let g:startify_change_to_vcs_root = 1

let g:startify_fortune_use_unicode = 1

let g:startify_session_persistence = 1

let g:startify_enable_special = 0

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']          },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ { 'c': '~/code' },
            \ { 'r': '~/code/ricoma' },
            \ { 'p': '~/code/playground' },
            \ { 'e': '~/Desktop' },
            \ { 'd': '~/Downloads' },
            \ ]

let g:startify_custom_header = [
      \'       ________   _______   ________  ___      ___ ___  _____ ______',
      \'      |\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \',
      \'      \ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \',   
      \'       \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \', 
      \'        \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \', 
      \'         \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\',
      \'          \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|']
