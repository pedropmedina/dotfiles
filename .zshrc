# # Show system info on startup
# neofetch

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Initiate starship prompt
eval "$(starship init zsh)"

# Enable Vim mode
bindkey -v

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

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Aliases
alias vim="nvim"
alias v="nvim"
