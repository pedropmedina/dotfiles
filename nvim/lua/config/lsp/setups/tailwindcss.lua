local tailwindcss = function(config)
    local opts = {
        settings = {
            includeLanguages = { typescript = 'javascript', typescriptreact = 'javascript' },
            tailwindCSS = {
                experimental = {
                    classRegex = {
                        'tw`([^`]*)',
                        'tw="([^"]*)',
                        'tw={"([^"}]*)',
                        'tw\\.\\w+`([^`]*)',
                        'tw\\(.*?\\)`([^`]*)'
                    }
                }
            }
        }
    }
    for k, v in pairs(config) do opts[k] = v end
    return opts
end

return tailwindcss
