-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- themes
  use 'joshdick/onedark.vim'

  -- lsp
  use 'neovim/nvim-lspconfig'

  -- completion
  use 'nvim-lua/completion-nvim'

  -- snippets
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    }
  }

  -- Syntax highlight and more
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-refactor'

  use {
    'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function() require'plugins.statusline' end
  }

  -- File tree
  use { 'kyazdani42/nvim-tree.lua' }

  -- Version control
  use 'mhinz/vim-signify'
  use 'tpope/vim-fugitive'

  -- Formatters
  use 'mhartington/formatter.nvim'

  -- Comment out code
  use 'tomtom/tcomment_vim'

  -- Surround text
  use 'tpope/vim-surround'

  -- Auto pairs for '(' '[' '{'
  use 'jiangmiao/auto-pairs'

  -- Colorize matching parentheses
  use 'junegunn/rainbow_parentheses.vim'

  -- Automatically clear highlight ( :nohls )
  use 'haya14busa/is.vim'

  --Search highlighted text with * or # from a visual block
  use 'nelstrom/vim-visual-star-search'

  -- temp support for .hbs files
  use 'mustache/vim-mustache-handlebars'
end)
