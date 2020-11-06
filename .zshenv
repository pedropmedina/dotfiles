# Default language
export LANG=en_US.UTF-8

# ZSH time to wait for additional characters
export KEYTIMEOUT=1

# Apps
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="Alacritty"
export COLORTERM="truecolor"
export PAGER="less"

# FZF + FD
FD_OPTIONS="--hidden --follow --color=always --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview-window='right:hidden:wrap' --bind='f2:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --type l $FD_OPTIONS || git ls-files --cached --others --exclude-standard"

# Add php composer package manager to PATH
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# Bat - Alternative to cat with syntax highlighting
# export BAT_PAGER="less -RF"
export BAT_THEME="OneHalfDark"

# Files and Directories colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# LF Icons
export LF_ICONS="\
  di=:\
  fi=:\
  ln=:\
  or=:\
  ex=:\
  *.vimrc=:\
  *.viminfo=:\
  *.gitignore=:\
  *.c=:\
  *.cc=:\
  *.clj=:\
  *.coffee=:\
  *.cpp=:\
  *.css=:\
  *.d=:\
  *.dart=:\
  *.erl=:\
  *.exs=:\
  *.fs=:\
  *.go=:\
  *.h=:\
  *.hh=:\
  *.hpp=:\
  *.hs=:\
  *.html=:\
  *.java=:\
  *.jl=:\
  *.js=:\
  *.json=:\
  *.lua=:\
  *.md=:\
  *.php=:\
  *.pl=:\
  *.pro=:\
  *.py=:\
  *.rb=:\
  *.rs=:\
  *.scala=:\
  *.ts=:\
  *.vim=:\
  *.cmd=:\
  *.ps1=:\
  *.sh=:\
  *.bash=:\
  *.zsh=:\
  *.fish=:\
  *.tar=:\
  *.tgz=:\
  *.arc=:\
  *.arj=:\
  *.taz=:\
  *.lha=:\
  *.lz4=:\
  *.lzh=:\
  *.lzma=:\
  *.tlz=:\
  *.txz=:\
  *.tzo=:\
  *.t7z=:\
  *.zip=:\
  *.z=:\
  *.dz=:\
  *.gz=:\
  *.lrz=:\
  *.lz=:\
  *.lzo=:\
  *.xz=:\
  *.zst=:\
  *.tzst=:\
  *.bz2=:\
  *.bz=:\
  *.tbz=:\
  *.tbz2=:\
  *.tz=:\
  *.deb=:\
  *.rpm=:\
  *.jar=:\
  *.war=:\
  *.ear=:\
  *.sar=:\
  *.rar=:\
  *.alz=:\
  *.ace=:\
  *.zoo=:\
  *.cpio=:\
  *.7z=:\
  *.rz=:\
  *.cab=:\
  *.wim=:\
  *.swm=:\
  *.dwm=:\
  *.esd=:\
  *.jpg=:\
  *.jpeg=:\
  *.mjpg=:\
  *.mjpeg=:\
  *.gif=:\
  *.bmp=:\
  *.pbm=:\
  *.pgm=:\
  *.ppm=:\
  *.tga=:\
  *.xbm=:\
  *.xpm=:\
  *.tif=:\
  *.tiff=:\
  *.png=:\
  *.svg=:\
  *.svgz=:\
  *.mng=:\
  *.pcx=:\
  *.mov=:\
  *.mpg=:\
  *.mpeg=:\
  *.m2v=:\
  *.mkv=:\
  *.webm=:\
  *.ogm=:\
  *.mp4=:\
  *.m4v=:\
  *.mp4v=:\
  *.vob=:\
  *.qt=:\
  *.nuv=:\
  *.wmv=:\
  *.asf=:\
  *.rm=:\
  *.rmvb=:\
  *.flc=:\
  *.avi=:\
  *.fli=:\
  *.flv=:\
  *.gl=:\
  *.dl=:\
  *.xcf=:\
  *.xwd=:\
  *.yuv=:\
  *.cgm=:\
  *.emf=:\
  *.ogv=:\
  *.ogx=:\
  *.aac=:\
  *.au=:\
  *.flac=:\
  *.m4a=:\
  *.mid=:\
  *.midi=:\
  *.mka=:\
  *.mp3=:\
  *.mpc=:\
  *.ogg=:\
  *.ra=:\
  *.wav=:\
  *.oga=:\
  *.opus=:\
  *.spx=:\
  *.xspf=:\
  *.pdf=:\
  *.nix=:\
  "
