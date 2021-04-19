local galaxyline = require('galaxyline')
local gl_buffer = require('galaxyline.provider_buffer')
local gl_vcs = require('galaxyline.provider_vcs')
local gl_cond = require('galaxyline.condition')
local gl_section = galaxyline.section
local COLORS = require('config.statusline.colors').NORD
local modes = require('config.statusline.modes')

local MODE_COLORS = modes.mode_colors(COLORS)
local MODE_TEXTS = modes.mode_texts()

galaxyline.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
    return false
end

-- Get project's root dit based off .git or fallback to ~
local root_path = function()
    local git_dir_path = gl_vcs.get_git_dir(vim.fn.expand('%:p:h'))
    return not git_dir_path and vim.fn.expand('%:~') or '...' .. vim.fn.expand('%:p'):sub(git_dir_path:len() - 4)
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then return true end
    return false
end

local separator = function(postfix, condition, provider, fg, bg)
    return {
        ['Separator' .. postfix] = {
            provider = function()
                return provider or ' '
            end,
            condition = function()
                return condition and condition() or true
            end,
            highlight = { fg or COLORS.darkest, bg or COLORS.darkest }
        }
    }
end

local git_diff = function(provider, condition, icon, fg, bg)
    return {
        [provider] = {
            provider = provider,
            condition = condition,
            icon = ' ' .. icon,
            highlight = { fg or COLORS.medium, bg or COLORS.darkest }
        }
    }
end

local cond = {
    branch = function()
        return gl_buffer.get_buffer_filetype() ~= '' and gl_cond.check_git_workspace() and gl_vcs.get_git_branch()
    end,
    git_separator = function()
        return gl_buffer.get_buffer_filetype() ~= '' and gl_cond.check_git_workspace()
    end
}

local prov = {
    block_indicator = function()
        vim.api.nvim_command('hi GalaxyBlockIndicator guibg=' .. MODE_COLORS[vim.fn.mode()])
        return ' '
    end,
    vi_mode = function()
        return MODE_TEXTS[vim.fn.mode()]
    end,
    dirty_buf = function()
        return vim.bo.mod and '  +  ' or ''
    end,
    branch = function()
        return '⠕ ' .. gl_vcs.get_git_branch() .. ' '
    end,
    buffer_type = function()
        return gl_buffer.get_buffer_filetype() ~= '' and gl_buffer.get_buffer_filetype() or 'VIM'
    end
}

local left = {
    { BlockIndicator = { provider = prov.block_indicator } },
    separator(1),
    { ViMode = { provider = prov.vi_mode, highlight = { COLORS.medium, COLORS.darkest } } },
    separator(2),
    { FileName = { condition = buffer_not_empty, provider = root_path, highlight = { COLORS.medium, COLORS.darkest } } },
    separator(3),
    { ModBuffer = { provider = prov.dirty_buf, highlight = { COLORS.success, COLORS.darkest } } },
    separator(4),
    { DiagnosticHint = { provider = 'DiagnosticHint', icon = '• ', highlight = { COLORS.info, COLORS.darkest } } },
    separator(5),
    { DiagnosticError = { provider = 'DiagnosticError', icon = '• ', highlight = { COLORS.error, COLORS.darkest } } },
    separator(6),
    { DiagnosticWarn = { provider = 'DiagnosticWarn', icon = '• ', highlight = { COLORS.warning, COLORS.darkest } } }
}

local right = {
    { GitBranch = { provider = prov.branch, condition = cond.branch, highlight = { COLORS.medium, COLORS.darkest } } },
    separator(7),
    git_diff('DiffAdd', checkwidth, '+', COLORS.success),
    git_diff('DiffModified', checkwidth, '~', COLORS.warning),
    git_diff('DiffRemove', checkwidth, '-', COLORS.error),
    separator(8, cond.git_separator, ' • ', COLORS.medium),
    { FileFormat = { provider = 'FileFormat', highlight = { COLORS.medium, COLORS.darkest } } },
    separator(9),
    { LineInfo = { provider = 'LineColumn', highlight = { COLORS.medium, COLORS.darkest } } },
    separator(10, nil, ' • ', COLORS.medium),
    { PerCent = { provider = 'LinePercent', highlight = { COLORS.medium, COLORS.darkest } } },
    separator(11, nil, ' ')
}

local short_left = {
    separator(12),
    { BufferType = { provider = prov.buffer_type, highlight = { COLORS.medium, COLORS.darkest } } }
}

local set_section = function(position, config)
    for i, table in ipairs(config) do gl_section[position][i] = table end
end

set_section('left', left)
set_section('right', right)
set_section('short_line_left', short_left)
