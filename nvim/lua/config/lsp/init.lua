require('config/lsp/diagnostics')
require('config/lsp/formatting')
local config = require('config/lsp/common_config')

local setups = {
    lua = require('config/lsp/setups/lua')(config),
    vim = require('config/lsp/setups/vim')(config),
    bash = require('config/lsp/setups/bash')(config),
    html = require('config/lsp/setups/html')(config),
    css = require('config/lsp/setups/css')(config),
    json = require('config/lsp/setups/json')(config),
    vue = require('config/lsp/setups/vue')(config),
    typescript = require('config/lsp/setups/typescript')(config),
    dockerfile = require('config/lsp/setups/dockerfile')(config),
    efm = require('config/lsp/setups/efm')(config),
    tailwindcss = require('config/lsp/setups/tailwindcss')(config)
}

local function setup_servers(servers_setup)
    local servers = require('lspinstall').installed_servers()
    for _, server in pairs(servers) do require('lspconfig')[server].setup(servers_setup[server]) end
end

setup_servers(setups)

require('lspinstall').post_install_hook = function()
    setup_servers(setups) -- reload installed servers
    vim.cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
end
