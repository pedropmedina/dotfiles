require('config/lsp/diagnostics')
require('config/lsp/formatting')

local setups = require('config/lsp/setups')
local function setup_servers(servers_setup)
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do require'lspconfig'[server].setup(servers_setup[server]) end
end

setup_servers(setups)

require('lspinstall').post_install_hook = function()
    setup_servers(setups) -- reload installed servers
    vim.cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
end
