" Vim Plugin Manager
source $HOME/.config/nvim/plugs/plugins.vim

" General Settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/highlights.vim
source $HOME/.config/nvim/general/commands.vim
source $HOME/.config/nvim/general/paths.vim

" Key Mappings
source $HOME/.config/nvim/keys/mappings.vim

" Themes
source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/lightline.vim

" .lua plugins - Move plugins after theme for better integration
luafile $HOME/.config/nvim/plugs-config/lua/lspconfig.lua
luafile $HOME/.config/nvim/plugs-config/lua/treesitter.lua

" .vim plugins
source $HOME/.config/nvim/plugs-config/vim/completion.vim
source $HOME/.config/nvim/plugs-config/vim/diagnostic.vim
source $HOME/.config/nvim/plugs-config/vim/fzf.vim
source $HOME/.config/nvim/plugs-config/vim/fern.vim
source $HOME/.config/nvim/plugs-config/vim/signify.vim
source $HOME/.config/nvim/plugs-config/vim/neoformat.vim
source $HOME/.config/nvim/plugs-config/vim/tagalong.vim
source $HOME/.config/nvim/plugs-config/vim/rainbow.vim
