return function()
    require('lspinstall').setup()
    require('config.lsp.diagnostics')
    require('config.lsp.formatting')

    local lspconfig = require('lspconfig')
    local installed_servers = require('lspinstall').installed_servers()
    local common_setup = require('config.lsp.common_setup')

    local function is_nil(tbl, val)
        return tbl[val] == nil
    end

    local function setup_servers(servers, setups)
        for _, server in pairs(servers) do
            if not is_nil(setups, server) then lspconfig[server].setup(setups[server]) end
        end
    end

    local function post_install_servers(servers, setups)
        require('lspinstall').post_install_hook = function()
            setup_servers(servers, setups)
            vim.cmd('bufdo e')
        end
    end

    local setups = {
        lua = require('config.lsp.setups.lua')(common_setup),
        vim = require('config.lsp.setups.vim')(common_setup),
        bash = require('config.lsp.setups.bash')(common_setup),
        rust = require('config.lsp.setups.rust')(common_setup),
        html = require('config.lsp.setups.html')(common_setup),
        css = require('config.lsp.setups.css')(common_setup),
        json = require('config.lsp.setups.json')(common_setup),
        vue = require('config.lsp.setups.vue')(common_setup),
        typescript = require('config.lsp.setups.typescript')(common_setup),
        dockerfile = require('config.lsp.setups.dockerfile')(common_setup),
        efm = require('config.lsp.setups.efm')(common_setup),
        tailwindcss = require('config.lsp.setups.tailwindcss')(common_setup)
    }

    setup_servers(installed_servers, setups)

    post_install_servers(installed_servers, setups)
end
