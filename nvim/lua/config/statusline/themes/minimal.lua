local gl = require('galaxyline')
local gl_buffer = require('galaxyline.provider_buffer')
local gl_vcs = require('galaxyline.provider_vcs')
local gl_diagnostic = require('galaxyline.provider_diagnostic')
local gl_fileinfo = require('galaxyline.provider_fileinfo')
local gl_section = gl.section

local COLORS = require('config.statusline.colors').NORD
local modes = require('config.statusline.modes')
local utils = require('config.statusline.utils')(COLORS)

local MODE_COLORS = modes.mode_colors(COLORS)
local MODE_TEXTS = modes.mode_texts()

gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

local providers = {
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
    utils.set_section('BlockIndicator', providers.block_indicator),
    utils.set_section('Separator_1'),
    utils.set_section('ViMode', providers.vi_mode, nil, nil, COLORS.medium),
    utils.set_section('Separator_2'),
    utils.set_section('FileName', utils.root_path, utils.buffer_not_empty, nil, COLORS.medium),
    utils.set_section('Separator_3'),
    utils.set_section('ModBuffer', providers.dirty_buf, nil, nil, COLORS.success),
    utils.set_section('Separator_4'),
    utils.set_section('DiagnosticHint', gl_diagnostic.get_diagnostic_hint, nil, '• ', COLORS.light),
    utils.set_section('Separator_5'),
    utils.set_section('DiagnosticError', gl_diagnostic.get_diagnostic_error, nil, '• ', COLORS.error),
    utils.set_section('Separator_6'),
    utils.set_section('DiagnosticWarn', gl_diagnostic.get_diagnostic_warn, nil, '• ', COLORS.warning)
}

local right = {
    utils.set_section('GitBranch', providers.branch, utils.has_git_branch, nil, COLORS.medium),
    utils.set_section('Separator_7'),
    utils.set_section('DiffAdd', gl_vcs.diff_add, utils.checkwidth, '+', COLORS.success),
    utils.set_section('DiffModified', gl_vcs.diff_modified, utils.checkwidth, '~', COLORS.warning),
    utils.set_section('DiffRemove', gl_vcs.diff_remove, utils.checkwidth, '-', COLORS.error),
    utils.set_section('Separator_8', ' • ', utils.has_git, nil, COLORS.medium),
    utils.set_section('FileFormat', gl_buffer.get_buffer_filetype, nil, nil, COLORS.medium),
    utils.set_section('Separator_9', '  • ', nil, nil, COLORS.medium),
    utils.set_section('LineInfo', gl_fileinfo.line_column, nil, nil, COLORS.medium),
    utils.set_section('Separator_10', ' • ', nil, nil, COLORS.medium),
    utils.set_section('PerCent', gl_fileinfo.current_line_percent, nil, nil, COLORS.medium),
    utils.set_section('Separator_11', ' ', nil)
}

local short_left = {
    utils.set_section('Separator_12'),
    utils.set_section('BufferType', providers.buffer_type, nil, nil, COLORS.medium)
}

local set_section_position = function(position, config)
    for i, table in ipairs(config) do gl_section[position][i] = table end
end

set_section_position('left', left)
set_section_position('right', right)
set_section_position('short_line_left', short_left)
