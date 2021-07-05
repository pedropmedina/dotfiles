-- check for packer (plugin manager) and install if not present
if not require('packer_install')() then return end

-- plugins - packer handles the config per plugin
require('plugins')

-- plugins config
-- require('config.treesitter')
-- require('config.theme')
-- require('config.statusline')
-- require('config.gitsigns')
-- require('config.lspinstall')
-- require('config.lsp')
-- require('config.completion')
-- require('config.tree')
-- require('config.telescope')
-- require('config.snippets')
-- require('config.comment')

-- general - ...
-- require('options')
-- require('mappings')
-- require('autocmds')
-- require('hosts')
