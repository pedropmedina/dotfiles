local gl_vcs = require('galaxyline.provider_vcs')
local gl_buffer = require('galaxyline.provider_buffer')
local gl_cond = require('galaxyline.condition')

local utils = function(colors)
    local u = {}

    function u.buffer_not_empty()
        if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
        return false
    end

    -- Get project's root dit based off .git or fallback to ~
    function u.root_path()
        local git_dir_path = gl_vcs.get_git_dir(vim.fn.expand('%:p:h'))
        return not git_dir_path and vim.fn.expand('%:~') or '...' .. vim.fn.expand('%:p'):sub(git_dir_path:len() - 4)
    end

    function u.has_git()
        return gl_buffer.get_buffer_filetype() ~= '' and gl_cond.check_git_workspace()
    end

    function u.has_git_branch()
        return gl_buffer.get_buffer_filetype() ~= '' and gl_cond.check_git_workspace() and gl_vcs.get_git_branch()
    end

    function u.checkwidth()
        local squeeze_width = vim.fn.winwidth(0) / 2
        if squeeze_width > 40 then return true end
        return false
    end

    function u.set_section(name, provider, condition, icon, fg, bg)
        local provider_cb = function(p)
            return function()
                return p and p or ' '
            end
        end

        local prov = not provider and provider_cb() or type(provider) == 'function' and provider or
                         provider_cb(provider)

        return {
            [name] = {
                provider = prov,
                condition = function()
                    if (condition) then return condition() end
                    return true
                end,
                icon = icon or nil,
                highlight = { fg or colors.darkest, bg or colors.darkest }
            }
        }
    end

    return u
end

return utils
