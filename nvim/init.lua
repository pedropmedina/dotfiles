-- plugins - packer handles the config per plugin
require('plugins')

-- plugins config
require('config.lspinstall')
require('config.lsp')
require('config.comment')
require('config.completion')
require('config.gitsigns')
require('config.snippets')
require('config.statusline')
require('config.telescope')
require('config.tree')
require('config.treesitter')

-- general - ...
require('options')
require('mappings')
require('autocmds')
require('hosts')
