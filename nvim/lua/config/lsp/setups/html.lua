-- https://github.com/vscode-langservers/vscode-html-languageserver-bin
local html = function(config)
    local opts = {
        filetypes = {
            'html',
            'tsx',
            'jsx',
            'vue',
            'hbs',
            'handlebars',
            'html.hbs',
            'html.handlebars',
            'liquid'
        }
    }
    for k, v in pairs(config) do opts[k] = v end
    return opts
end

return html
