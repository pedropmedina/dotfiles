-- https://github.com/sumneko/lua-language-server
local lua = function(config)
    local opts = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
                diagnostics = { enable = true, globals = { 'vim', 'use', 'packer_plugins' } },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                    }
                }
            }
        }
    }
    for k, v in pairs(config) do opts[k] = v end
    return opts
end

return lua

