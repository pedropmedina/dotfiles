# Path to your oh-my-zsh installation.
export ZSH="/Users/pedropmedina/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Default language
export LANG=en_US.UTF-8

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  pyenv 
  mix
  node 
  npm
  yarn
  npx 
  nvm 
  fast-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Spaceship prompt configurations
# SPACESHIP_PROMPT_ORDER=()
# SPACESHIP_CHAR_SYMBOL="❯"
# SPACESHIP_CHAR_SYMBOL_SECONDARY="❯ "
SPACESHIP_CHAR_SYMBOL="|>"
SPACESHIP_CHAR_SYMBOL_SECONDARY="|> "
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_VI_MODE_SHOW=false
SPACESHIP_VI_MODE_PREFIX=""

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Enable Vim mode
bindkey -v
export KEYTIMEOUT=1

# delete with backspace in insert mode
bindkey "^?" backward-delete-char

# Change cursor shape between beam and block
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q' 

# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;} 

# For a full list of active aliases, run `alias`.
alias vim="nvim"
alias v="nvim"

# autogenerate .gitignore from https://docs.gitignore.io
function gi() { curl -sLw n https://www.gitignore.io/api/$@ ;}

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Add php composer package manager to PATH
export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# FZF
FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules --exclude .pyenv --exclude .composer"
export FZF_DEFAULT_OPTS="--no-mouse --height 100% --layout reverse --margin=1,4 --multi --inline-info --color 'gutter:#282c34' --ansi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:60%:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort'"
export FZF_DEFAULT_COMMAND="fd --type file --color=always $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --color=always $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

# fzf key bindings and auto completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bat - alternative to cat with syntax highlighting
# export BAT_PAGER="less -RF"
export BAT_THEME="OneHalfDark"
