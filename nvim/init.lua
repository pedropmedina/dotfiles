-- check for packer (plugin manager) and install if not present
if not require('packer_install')() then return end

-- plugins - packer handles config per plugin
require('plugins')

-- general - ...
require('options')
require('mappings')
require('autocmds')
require('hosts')

-- cleaner term buffer
vim.api.nvim_exec([[
au BufEnter term://* setlocal nonumber
   au BufEnter term://* set laststatus=0 
]], false)
