local galaxyline = require('galaxyline')
local gl_buffer = require('galaxyline.provider_buffer')
local gl_vcs = require('galaxyline.provider_vcs')
local gl_cond = require('galaxyline.condition')
local gl_section = galaxyline.section
local gl_diagnostic = require('galaxyline.provider_diagnostic')
local gl_fileinfo = require('galaxyline.provider_fileinfo')
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

local set_section = function(name, provider, condition, icon, fg, bg)
    local provider_cb = function(p)
        return function()
            return p and p or ' '
        end
    end

    local prov = not provider and provider_cb() or type(provider) == 'function' and provider or provider_cb(provider)

    return {
        [name] = {
            provider = prov,
            condition = function()
                if (condition) then return condition() end
                return true
            end,
            icon = icon or nil,
            highlight = { fg or COLORS.darkest, bg or COLORS.darkest }
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
    set_section('BlockIndicator', prov.block_indicator),
    set_section('Separator_1'),
    set_section('ViMode', prov.vi_mode, nil, nil, COLORS.medium),
    set_section('Separator_2'),
    set_section('FileName', root_path, buffer_not_empty, nil, COLORS.medium),
    set_section('Separator_3'),
    set_section('ModBuffer', prov.dirty_buf, nil, nil, COLORS.success),
    set_section('Separator_4'),
    set_section('DiagnosticHint', gl_diagnostic.get_diagnostic_hint, nil, '• ', COLORS.light),
    set_section('Separator_5'),
    set_section('DiagnosticError', gl_diagnostic.get_diagnostic_error, nil, '• ', COLORS.error),
    set_section('Separator_6'),
    set_section('DiagnosticWarn', gl_diagnostic.get_diagnostic_warn, nil, '• ', COLORS.warning)
}

local right = {
    set_section('GitBranch', prov.branch, cond.branch, nil, COLORS.medium),
    set_section('Separator_7'),
    set_section('DiffAdd', gl_vcs.diff_add, checkwidth, '+', COLORS.success),
    set_section('DiffModified', gl_vcs.diff_modified, checkwidth, '~', COLORS.warning),
    set_section('DiffRemove', gl_vcs.diff_remove, checkwidth, '-', COLORS.error),
    set_section('Separator_8', ' • ', cond.git_separator, nil, COLORS.medium),
    set_section('FileFormat', gl_buffer.get_buffer_filetype, nil, nil, COLORS.medium),
    set_section('Separator_9', '  • ', nil, nil, COLORS.medium),
    set_section('LineInfo', gl_fileinfo.line_column, nil, nil, COLORS.medium),
    set_section('Separator_10', ' • ', nil, nil, COLORS.medium),
    set_section('PerCent', gl_fileinfo.current_line_percent, nil, nil, COLORS.medium),
    set_section('Separator_11', ' ', nil)
}

local short_left = { set_section('Separator_12'), set_section('BufferType', prov.buffer_type, nil, nil, COLORS.medium) }

local set_section_position = function(position, config)
    for i, table in ipairs(config) do gl_section[position][i] = table end
end

set_section_position('left', left)
set_section_position('right', right)
set_section_position('short_line_left', short_left)
