" Vim Plugin Manager
source $HOME/.config/nvim/vim-plug/plugins.vim

" General Settings
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/paths.vim

" Key Mappings
source $HOME/.config/nvim/keys/mappings.vim

" Themes
source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/lightline.vim

" .lua plugins - Move plugins after theme for better integration
luafile $HOME/.config/nvim/plug-config/lua/lspconfig.lua
luafile $HOME/.config/nvim/plug-config/lua/treesitter.lua

" .vim plugins
source $HOME/.config/nvim/plug-config/vim/completion.vim
source $HOME/.config/nvim/plug-config/vim/diagnostic.vim
source $HOME/.config/nvim/plug-config/vim/fzf.vim
source $HOME/.config/nvim/plug-config/vim/fern.vim
source $HOME/.config/nvim/plug-config/vim/signify.vim
source $HOME/.config/nvim/plug-config/vim/neoformat.vim
source $HOME/.config/nvim/plug-config/vim/tagalong.vim
source $HOME/.config/nvim/plug-config/vim/rainbow.vim
source $HOME/.config/nvim/plug-config/vim/autopairs.vim
