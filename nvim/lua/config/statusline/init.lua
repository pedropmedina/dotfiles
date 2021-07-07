return function()
    local gl = require('galaxyline')
    local gl_buffer = require('galaxyline.provider_buffer')
    local gl_vcs = require('galaxyline.provider_vcs')
    local gl_diagnostic = require('galaxyline.provider_diagnostic')
    local gl_fileinfo = require('galaxyline.provider_fileinfo')
    local gl_section = gl.section

    local colors = require('colors')
    local modes = require('config.statusline.modes')
    local utils = require('config.statusline.utils')(colors)

    local mode_colors = modes.mode_colors(colors)
    local mode_texts = modes.mode_texts()

    gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

    local providers = {
        vi_mode = function()
            vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_colors[vim.fn.mode()])
            return mode_texts[vim.fn.mode()]
        end,
        vi_mode_icon_1 = function()
            vim.api.nvim_command('hi GalaxyViModeIcon_1 guibg=' .. mode_colors[vim.fn.mode()])
            return '   '
        end,
        vi_mode_icon_2 = function()
            vim.api.nvim_command('hi GalaxyViModeIcon_2 guifg=' .. mode_colors[vim.fn.mode()])
            return ''
        end,
        dirty_buf = function()
            return vim.bo.mod and '  +  ' or ''
        end,
        git_branch = function()
            vim.api.nvim_command(
                'hi GalaxyGitBranch' .. ' guifg=' .. colors.black .. ' guibg=' .. colors.gray
            )
            return '   ' .. gl_vcs.get_git_branch() .. ' '
        end,
        buffer_type = function()
            return gl_buffer.get_buffer_filetype() ~= '' and gl_buffer.get_buffer_filetype() ~=
                       'NVIMTREE' and gl_buffer.get_buffer_filetype() or ''
        end
    }

    local left = {
        utils.set_section('Separator'),
        utils.set_section('ViMode', providers.vi_mode, nil, nil, colors.gray),
        utils.set_section('ViModeIcon_1', providers.vi_mode_icon_1),
        utils.set_section('ViModeIcon_2', providers.vi_mode_icon_2),
        utils.set_section('Separator_2', '    '),
        utils.set_section(
            'FileIcon', gl_fileinfo.get_file_icon, utils.buffer_not_empty, nil, colors.light_gray
        ),
        utils.set_section(
            'FileName', utils.root_path, utils.buffer_not_empty, nil, colors.light_gray
        ),
        utils.set_section('Separator_3'),
        utils.set_section('ModBuffer', providers.dirty_buf, nil, nil, colors.green),
        utils.set_section('Separator_4'),
        utils.set_section(
            'DiagnosticHint', gl_diagnostic.get_diagnostic_hint, nil, '• ', colors.light_gray
        ),
        utils.set_section('Separator_5'),
        utils.set_section(
            'DiagnosticError', gl_diagnostic.get_diagnostic_error, nil, '• ', colors.red
        ),
        utils.set_section('Separator_6'),
        utils.set_section(
            'DiagnosticWarn', gl_diagnostic.get_diagnostic_warn, nil, '• ', colors.yellow
        )
    }

    local right = {
        utils.set_section('GitBranch', providers.git_branch, utils.has_git_branch),
        utils.set_section(
            'DiffAdd', gl_vcs.diff_add, utils.has_git_branch, '+', colors.green, colors.gray
        ),
        utils.set_section(
            'DiffModified', gl_vcs.diff_modified, utils.has_git_branch, '~', colors.yellow,
            colors.gray
        ),
        utils.set_section(
            'DiffRemove', gl_vcs.diff_remove, utils.has_git_branch, '-', colors.red, colors.gray
        ),
        utils.set_section('Separator_7', ' ', utils.has_git_branch, nil, nil, colors.gray),
        utils.set_section('Separator_8', ' ', utils.has_git_branch, nil, nil, colors.dark_gray),
        utils.set_section('Separator_9', '   ', nil, nil, colors.black, colors.gray),
        utils.set_section(
            'LineInfo', gl_fileinfo.line_column, nil, nil, colors.light_gray, colors.gray
        ),
        utils.set_section('Separator_10', ' ', nil, nil, colors.light_gray, colors.gray),
        utils.set_section(
            'PerCent', gl_fileinfo.current_line_percent, nil, nil, colors.light_gray, colors.gray
        )
    }

    local short_left = {
        utils.set_section('Separator_11', ' ', nil, nil, nil, colors.dark_black),
        utils.set_section(
            'BufferType', providers.buffer_type, nil, nil, colors.gray, colors.dark_black
        )
    }

    local set_section_position = function(position, config)
        for i, table in ipairs(config) do gl_section[position][i] = table end
    end

    set_section_position('left', left)
    set_section_position('right', right)
    set_section_position('short_line_left', short_left)
end
