-- https://github.com/mattn/efm-langserver
local efm = function(config)
    -- Let's use vim-rooter here to find the project's root since in a monorepo
    -- style project the node_modules at the app level is empty and the binaries
    -- are kept at the monorepo root level
    local root_path = vim.g.project_root_path

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
    local prettier_bin = (root_path ~= nil and root_path ~= '') and root_path ..
                             '/node_modules/.bin/prettier' or './node_modules/.bin/prettier'
    local prettier = {
        formatCommand = prettier_bin .. ([[
            --stdin-filepath %
            --config-precedence prefer-file
            --tab-width 2
            --single-quote
            --print-width 100
        ]]):gsub('\n', '')
    }

    -- https://eslint.org/
    local eslint_bin = (root_path ~= nil and root_path ~= '') and root_path ..
                           '/node_modules/.bin/eslint' or './node_modules/.bin/eslint'
    local eslint = {
        lintCommand = eslint_bin .. ' -f visualstudio --stdin --stdin-filename ${INPUT}',
        lintIgnoreExitCode = true,
        lintStdin = true,
        lintFormats = { '%f(%l,%c): %tarning %m', '%f(%l,%c): %trror %m' }
    }

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
            rootMarkers = { '.git/', 'package.json' },
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
