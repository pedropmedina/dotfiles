local lspconfig = require("lspconfig")
require("plugins/config/lspconfig/diagnostics")
require("plugins/config/lspconfig/formatting")

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- required to ensure lsp completion :h lsp-buf
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "<Leader>dl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "<Leader>dk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "<Leader>dj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<Leader>do", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    if client.resolved_capabilities.type_definition then
        buf_set_keymap("n", "<Leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    end
    if client.resolved_capabilities.signature_help then
        buf_set_keymap("n", "<Leader>gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    end
    if client.resolved_capabilities.implementation then
        buf_set_keymap("n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    end
    if client.resolved_capabilities.code_action then
        buf_set_keymap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    end
    if client.resolved_capabilities.range_code_action then
        buf_set_keymap("x", "<Leader>ca", "<cmd>'<'>lua vim.lsp.buf.range_code_action()<CR>", opts)
    end
    if client.resolved_capabilities.document_formatting then
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
        vim.cmd [[augroup END]]

        buf_set_keymap("n", "<Leader>gf", "<cmd>lua formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<Leader>gf", "<cmd>lua formatting()<CR>", opts)
    end
    if client.resolved_capabilities.goto_definition then
        buf_set_keymap("n", "<Leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    end
    if client.resolved_capabilities.hover then
        buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "<Leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    end
    if client.resolved_capabilities.find_references then
        buf_set_keymap("n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    end
    if client.resolved_capabilities.rename then
        buf_set_keymap("n", "<Leader>grn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    end
end

-- System name
local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
    system_name = "Windows"
else
    print("Unsupported system.")
end

-- Set the path to the sumneko installation
local sumneko_root_path = vim.fn.expand("~") .. "/lspconfig/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

lspconfig.sumneko_lua.setup(
    {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
                diagnostics = { enable = true, globals = { "vim", "use", "packer_plugins" } },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                }
            }
        }
    }
)

-- Enable (broadcasting) snippet capability for [html, css] completion - No sure if this will be needed in the future
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
lspconfig.html.setup {
    cmd = { "html-languageserver", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "tsx", "jsx", "vue", "hbs", "handlebars", "html.hbs", "html.handlebars", "liquid" }
}

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
lspconfig.cssls.setup {
    cmd = { "css-languageserver", "--stdio" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { css = { validate = false } }
}

-- https://github.com/theia-ide/typescript-language-server
lspconfig.tsserver.setup(
    {
        on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            on_attach(client)
        end
    }
)

-- https://github.com/iamcco/vim-language-server
lspconfig.vimls.setup({ on_attach = on_attach })

-- https://github.com/bash-lsp/bash-language-server
lspconfig.bashls.setup { on_attach = on_attach }

-- https://github.com/vscode-langservers/vscode-json-languageserver
lspconfig.jsonls.setup({ on_attach = on_attach, cmd = { "json-languageserver", "--stdio" } })

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
lspconfig.cssls.setup({ on_attach = on_attach })

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
lspconfig.html.setup({ on_attach = on_attach })

-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
lspconfig.dockerls.setup({ on_attach = on_attach })

-- https://github.com/vuejs/vetur/tree/master/server
lspconfig.vuels.setup { on_attach = on_attach }

local prettier = require("plugins/config/lspconfig/efm/prettier")
local eslint = require("plugins/config/lspconfig/efm/eslint")
local luaformat = require("plugins/config/lspconfig/efm/luaformat")

-- https://github.com/mattn/efm-langserver
lspconfig.efm.setup(
    {
        on_attach = on_attach,
        init_options = { documentFormatting = true },
        filetypes = {
            "lua", "typescript", "javascript", "javascriptreact", "typescriptreact", "html", "css", "scss", "json",
            "yaml", "markdown"
        },
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                lua = { luaformat },
                typescript = { prettier, eslint },
                javascript = { prettier, eslint },
                typescriptreact = { prettier, eslint },
                javascriptreact = { prettier, eslint },
                yaml = { prettier },
                json = { prettier },
                html = { prettier },
                scss = { prettier },
                css = { prettier },
                markdown = { prettier }
            }
        }
    }
)
