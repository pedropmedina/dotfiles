#!/bin/bash

# Machine setup script for the dotfiles in this repository.

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
NVM_INSTALL_VERSION="v0.40.4"

echo "Starting machine setup with dotfiles..."

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}INFO:${NC} $1"
}

log_success() {
    echo -e "${GREEN}OK:${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}WARN:${NC} $1"
}

log_error() {
    echo -e "${RED}ERROR:${NC} $1"
}

nvm_dir() {
    if [ -z "${XDG_CONFIG_HOME-}" ]; then
        printf %s "${HOME}/.nvm"
    else
        printf %s "${XDG_CONFIG_HOME}/nvm"
    fi
}

ensure_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        return
    fi

    log_info "Homebrew not found. Installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    if ! command -v brew >/dev/null 2>&1; then
        log_error "Homebrew installation completed, but brew is not available in the current shell."
        exit 1
    fi
}

ensure_prezto() {
    local zdotdir="${ZDOTDIR:-$HOME}"
    local prezto_dir="${zdotdir}/.zprezto"

    if [ -f "${prezto_dir}/init.zsh" ]; then
        log_info "Prezto already installed at ${prezto_dir}"
        return
    fi

    if [ -e "${prezto_dir}" ]; then
        log_error "${prezto_dir} exists but does not look like a valid Prezto install"
        exit 1
    fi

    if ! command -v git >/dev/null 2>&1; then
        log_error "git is required to install Prezto"
        exit 1
    fi

    log_info "Installing Prezto into ${prezto_dir}"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${prezto_dir}"
    log_success "Installed Prezto"
}

backup_existing() {
    local target="$1"

    if [ -e "$target" ] || [ -L "$target" ]; then
        local backup="${target}.backup.${TIMESTAMP}"
        log_warning "Backing up ${target} to ${backup}"
        mv "$target" "$backup"
    fi
}

link_path() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        log_info "${target} already points to ${source}"
        return
    fi

    backup_existing "$target"
    ln -s "$source" "$target"
    log_success "Linked ${target}"
}

create_directories() {
    log_info "Creating base directories"

    for dir in \
        "$HOME/.config" \
        "$HOME/.local/bin" \
        "$HOME/.local/share" \
        "$HOME/.cache"; do
        if [ -d "$dir" ]; then
            log_info "${dir} already exists"
        else
            mkdir -p "$dir"
            log_success "Created ${dir}"
        fi
    done

    log_success "Base directories created"
}

setup_shell() {
    log_info "Linking shell configuration"
    link_path "${SCRIPT_DIR}/.zshrc" "$HOME/.zshrc"
    link_path "${SCRIPT_DIR}/.zshenv" "$HOME/.zshenv"
    link_path "${SCRIPT_DIR}/.zprofile" "$HOME/.zprofile"
    link_path "${SCRIPT_DIR}/.zpreztorc" "$HOME/.zpreztorc"
}

setup_git() {
    log_info "Linking Git configuration"
    link_path "${SCRIPT_DIR}/.gitconfig" "$HOME/.gitconfig"
    link_path "${SCRIPT_DIR}/.gitignore" "$HOME/.gitignore"
}

setup_terminal() {
    log_info "Linking terminal configuration"
    link_path "${SCRIPT_DIR}/ghostty" "$HOME/.config/ghostty"
}

setup_editors() {
    log_info "Linking editor configuration"
    link_path "${SCRIPT_DIR}/nvim" "$HOME/.config/nvim"
    link_path "${SCRIPT_DIR}/.vimrc" "$HOME/.vimrc"
    link_path "${SCRIPT_DIR}/.ideavimrc" "$HOME/.ideavimrc"
}

setup_tools() {
    log_info "Linking prompt and database tooling"
    link_path "${SCRIPT_DIR}/starship.toml" "$HOME/.config/starship.toml"
    link_path "${SCRIPT_DIR}/.psqlrc" "$HOME/.psqlrc"
}

install_tree_sitter_cli() {
    if command -v tree-sitter >/dev/null 2>&1; then
        log_info "tree-sitter-cli already installed"
        return
    fi

    if ! command -v cargo >/dev/null 2>&1; then
        log_error "cargo is required to install tree-sitter-cli"
        exit 1
    fi

    if command -v cargo-binstall >/dev/null 2>&1; then
        log_info "Installing tree-sitter-cli with cargo-binstall"
        cargo binstall --no-confirm tree-sitter-cli
    else
        log_info "cargo-binstall not found. Building tree-sitter-cli from source."
        cargo install --locked tree-sitter-cli
    fi

    log_success "Installed tree-sitter-cli"
}

install_nvm() {
    log_info "Installing or updating nvm"

    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_INSTALL_VERSION}/install.sh" | PROFILE=/dev/null bash
    elif command -v wget >/dev/null 2>&1; then
        wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_INSTALL_VERSION}/install.sh" | PROFILE=/dev/null bash
    else
        log_error "curl or wget is required to install nvm"
        exit 1
    fi

    log_success "Installed or updated nvm"
}

install_latest_node_with_nvm() {
    local nvm_install_dir
    nvm_install_dir="$(nvm_dir)"

    if [ ! -s "${nvm_install_dir}/nvm.sh" ]; then
        log_error "nvm installation was not found at ${nvm_install_dir}"
        exit 1
    fi

    export NVM_DIR="${nvm_install_dir}"
    # shellcheck disable=SC1090
    . "${NVM_DIR}/nvm.sh"

    log_info "Installing the latest Node.js release with nvm"
    nvm install node
    nvm alias default node
    nvm use default
    log_success "Installed the latest Node.js release with nvm"
}

install_dependencies() {
    log_info "Installing dependencies for the configs in this repository"

    if [ "$(uname -s)" = "Darwin" ]; then
        ensure_homebrew
        brew install zsh git neovim vim starship rust cargo-binstall
        install_tree_sitter_cli
        brew install --cask ghostty
    elif command -v apt >/dev/null 2>&1; then
        echo "  sudo apt install zsh git neovim vim starship cargo curl"
        echo "  cargo install cargo-binstall --locked"
        echo "  cargo binstall tree-sitter-cli"
        echo "  # or fallback: cargo install --locked tree-sitter-cli"
        echo "  Ghostty may need to be installed separately."
    elif command -v pacman >/dev/null 2>&1; then
        echo "  sudo pacman -S zsh git neovim vim starship rust curl"
        echo "  cargo install cargo-binstall --locked"
        echo "  cargo binstall tree-sitter-cli"
        echo "  # or fallback: cargo install --locked tree-sitter-cli"
        echo "  Ghostty may need to be installed separately."
    else
        log_warning "No supported package manager detected. Install zsh, git, neovim, vim, starship, rust/cargo, cargo-binstall, tree-sitter-cli, and ghostty manually."
    fi

    install_nvm
    install_latest_node_with_nvm
}

main() {
    create_directories
    install_dependencies
    ensure_prezto
    setup_shell
    setup_git
    setup_terminal
    setup_editors
    setup_tools

    echo ""
    log_success "Dotfiles setup completed"
    log_info "Configured: zsh, prezto, git, ghostty, neovim, vim, IdeaVim, starship, rust/cargo, cargo-binstall, tree-sitter-cli, nvm, node, psqlrc"
    log_info "Restart your shell or run 'source ~/.zshrc' to apply shell changes."
}

main "$@"
