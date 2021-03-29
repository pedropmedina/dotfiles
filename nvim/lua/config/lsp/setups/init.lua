local config = require('config/lsp/setups/common')

return {
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
