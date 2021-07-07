-- https://github.com/Koihik/LuaFormatter
local luaformat = {
    formatCommand = ([[
        lua-format -i
        --no-keep-simple-function-one-line
        --column-limit=100
        --double-quote-to-single-quote 
        --spaces-around-equals-in-field
        --spaces-inside-table-braces
        --break-before-functioncall-rp
        --break-after-functioncall-lp
        --chop-down-table
    ]]):gsub('\n', ''),
    formatStdin = true
}

-- https://prettier.io/
local prettier = {
    formatCommand = ([[
        ./node_modules/.bin/prettier
        --stdin-filepath %
        --config-precedence prefer-file
        --tab-width 2
        --single-quote
        --print-width 100
    ]]):gsub('\n', '')
}

-- https://eslint.org/
local eslint = {
    lintCommand = './node_modules/.bin/eslint -f unix --stdin',
    lintIgnoreExitCode = true,
    lintStdin = true
}

-- https://github.com/mattn/efm-langserver
local efm = function(config)
    local opts = {
        init_options = { documentFormatting = true },
        filetypes = {
            'lua',
            'typescript',
            'javascript',
            'javascriptreact',
            'typescriptreact',
            'html',
            'css',
            'scss',
            'json',
            'yaml',
            'markdown',
            'vue'
        },
        settings = {
            rootMarkers = { '.git/', 'node_modules/', 'package.json' },
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
                markdown = { prettier },
                vue = { prettier }
            }
        }
    }
    for k, v in pairs(config) do opts[k] = v end
    return opts
end

return efm
