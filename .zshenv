# Default language
export LANG=en_US.UTF-8

# ZSH time to wait for additional characters
export KEYTIMEOUT=1

# Set TERM to xterm-256color-italic in order to enable italic comments
export TERM=xterm-256color-italic

# Apps
export TERMINAL="Alacritty"
export EDITOR="nvim"
export VISUAL="nvim"
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
export BAT_THEME="Nord"

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

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
