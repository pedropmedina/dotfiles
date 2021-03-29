-- https://github.com/theia-ide/typescript-language-server
local function typescript(config)
    local opts = {}
    for k, v in pairs(config) do
        if k == 'on_attach' then
            opts[k] = function(client)
                client.resolved_capabilities.document_formatting = false
                v(client)
            end
        else
            opts[k] = v
        end
    end
    return opts
end

return typescript
