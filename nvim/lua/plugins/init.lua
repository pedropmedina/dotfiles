-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- Install packer if not preset in ~/.local/share/nvim/site/pack/packer/opt
if not packer_exists then
  if vim.fn.input("Download Packer? ( y for yes ) ") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")
  print("( Restart now, then run :PackerInstall and :PackerCompile to install/configure plugins! )")
  return
end

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  -- Themes
  use { 'joshdick/onedark.vim',
    config = [[require('plugins.config.onedark')]],
    after = { 'telescope.nvim', 'nvim-tree.lua' }
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = [[
      require('plugins.config.lsp_config')
      require('plugins.config.diagnostics')
    ]]
  }

  -- Completion
  use { 'nvim-lua/completion-nvim', config = [[require('plugins.config.completion_nvim')]] }

  -- Snippets
  use {
    'hrsh7th/vim-vsnip',
    requires = { { 'hrsh7th/vim-vsnip-integ', after = 'vim-vsnip' } },
    config = [[require('plugins.config.snippets')]]
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'}
    },
    config = [[require('plugins.config.telescope')]]
  }

  -- Treesitter support
  use { 'theHamsta/nvim-treesitter',
    branch = 'lockfile',
    config = [[require('plugins.config.treesitter')]],
    run = ':TSUpdate'
  }
  use { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' }

  -- Colors
  use { 'norcalli/nvim-colorizer.lua' }

  -- Status line
  use {
    'glepnir/galaxyline.nvim',
      branch = 'main',
      config = [[require('plugins.config.statusline')]]
  }

  -- File tree
  use { 'kyazdani42/nvim-tree.lua', config = [[require('plugins.config.nvim_tree')]] }

  -- Version control
  use { 'tpope/vim-fugitive' }
  use { 'lewis6991/gitsigns.nvim', config = [[require('plugins.config.gitsigns')]]  }

  -- Formatters
  use { 'mhartington/formatter.nvim', config = [[require('plugins.config.formatter')]]}

  -- Comment out code
  use 'tomtom/tcomment_vim'

  -- Surround text
  use 'tpope/vim-surround'

  -- Auto pairs for '(' '[' '{'
  use 'jiangmiao/auto-pairs'

  -- Colorize matching parentheses
  use {
    'junegunn/rainbow_parentheses.vim',
    config = [[require('plugins.config.rainbow')]]
  }

  -- Automatically clear highlight ( :nohls )
  use 'haya14busa/is.vim'

  --Search highlighted text with * or # from a visual block
  use 'nelstrom/vim-visual-star-search'

  -- temp support for .hbs files
  use 'mustache/vim-mustache-handlebars'
end)

