local galaxyline = require('galaxyline')
local buffer = require('galaxyline.provider_buffer')
local vcs = require('galaxyline.provider_vcs')
local cond = require('galaxyline.condition')
local section = galaxyline.section

galaxyline.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

local COLORS = {
    nord0_gui = '#2E3440',
    nord1_gui = '#3B4252',
    nord2_gui = '#434C5E',
    nord3_gui = '#4C566A',
    nord3_gui_bright = '#616E88',
    nord4_gui = '#D8DEE9',
    nord5_gui = '#E5E9F0',
    nord6_gui = '#ECEFF4',
    nord7_gui = '#8FBCBB',
    nord8_gui = '#88C0D0',
    nord9_gui = '#81A1C1',
    nord10_gui = '#5E81AC',
    nord11_gui = '#BF616A',
    nord12_gui = '#D08770',
    nord13_gui = '#EBCB8B',
    nord14_gui = '#A3BE8C',
    nord15_gui = '#B48EAD'
}

local MODE_COLORS = {
    n = COLORS.nord7_gui,
    i = COLORS.nord14_gui,
    c = COLORS.nord11_gui,
    R = COLORS.nord9_gui,
    t = COLORS.nord9_gui,
    S = COLORS.nord13_gui,
    s = COLORS.nord13_gui,
    V = COLORS.nord13_gui,
    v = COLORS.nord13_gui,
    [''] = COLORS.nord13_gui
}

local MODE_TEXTS = {
    n = ' • normal • ',
    i = ' • insert • ',
    c = ' • command • ',
    R = ' • replace • ',
    t = ' • terminal • ',
    S = ' • select • ',
    s = ' • select • ',
    V = ' • visual • ',
    v = ' • visual • ',
    [''] = ' • visual •'
}

local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then return true end
    return false
end

-- Get project's root dit based on .git or fallback to ~
local root_path = function()
    local git_dir_path = vcs.get_git_dir(vim.fn.expand('%:p:h'))
    return not git_dir_path and vim.fn.expand('%:~') or '...' .. vim.fn.expand('%:p'):sub(git_dir_path:len() - 4)
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then return true end
    return false
end

section.left[1] = {
    BlockIndicator = {
        provider = function()
            vim.api.nvim_command('hi GalaxyBlockIndicator guibg=' .. MODE_COLORS[vim.fn.mode()])
            return ' '
        end
    }
}

section.left[2] = {
    BlockSeparator = {
        provider = function()
            return ' '
        end,
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}

section.left[3] = {
    ViMode = {
        provider = function()
            return MODE_TEXTS[vim.fn.mode()]
        end,
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}

section.left[4] = {
    FileName = {
        condition = buffer_not_empty,
        provider = root_path,
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}

section.left[5] = {
    ModBuffer = {
        provider = function()
            return vim.bo.mod and '  +  ' or ''
        end,
        highlight = { COLORS.nord14_gui, COLORS.nord1_gui }
    }
}

section.left[6] = {
    DiagnosticHint = { provider = 'DiagnosticHint', icon = '• ', highlight = { COLORS.nord10_gui, COLORS.nord1_gui } }
}

section.left[7] = {
    DiagnosticSepartor1 = {
        provider = function()
            return ' '
        end,
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}

section.left[8] = {
    DiagnosticError = { provider = 'DiagnosticError', icon = '• ', highlight = { COLORS.nord11_gui, COLORS.nord1_gui } }
}

section.left[9] = {
    DiagnosticSepartor2 = {
        provider = function()
            return ' '
        end,
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}

section.left[10] = {
    DiagnosticWarn = { provider = 'DiagnosticWarn', icon = '• ', highlight = { COLORS.nord12_gui, COLORS.nord1_gui } }
}

section.right[1] = {
    GitBranch = {
        provider = function()
            return '⠕ ' .. vcs.get_git_branch() .. ' '
        end,
        condition = function()
            return buffer.get_buffer_filetype() ~= '' and cond.check_git_workspace() and vcs.get_git_branch()
        end,
        separator = ' ',
        separator_highlight = { COLORS.nord1_gui, COLORS.nord2_gui },
        highlight = { COLORS.nord3_gui_bright, COLORS.nord2_gui }
    }
}

section.right[2] = {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = ' +',
        highlight = { COLORS.nord14_gui, COLORS.nord2_gui }
    }
}

section.right[3] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = { COLORS.nord12_gui, COLORS.nord2_gui }
    }
}

section.right[4] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = { COLORS.nord11_gui, COLORS.nord2_gui }
    }
}

section.right[5] = {
    GitSeparator = {
        condition = function()
            return buffer.get_buffer_filetype() ~= '' and cond.check_git_workspace()
        end,
        provider = function()
            return ' •'
        end,
        highlight = { COLORS.nord3_gui_bright, COLORS.nord2_gui }
    }
}

section.right[6] = {
    FileFormat = {
        provider = 'FileFormat',
        separator = ' ',
        separator_highlight = { COLORS.nord1_gui, COLORS.nord2_gui },
        highlight = { COLORS.nord3_gui_bright, COLORS.nord2_gui }
    }
}

section.right[7] = {
    LineInfo = {
        provider = 'LineColumn',
        separator = ' • ',
        separator_highlight = { COLORS.nord3_gui_bright, COLORS.nord2_gui },
        highlight = { COLORS.nord3_gui_bright, COLORS.nord2_gui }
    }
}

section.right[8] = {
    Space4 = {
        provider = function()
            return ' '
        end,
        highlight = { COLORS.nord1_gui, COLORS.nord2_gui }
    }
}

section.right[9] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = { COLORS.nord1_gui, COLORS.nord1_gui },
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}

section.short_line_left[1] = {
    Space5 = {
        provider = function()
            return ' '
        end,
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}

section.short_line_left[2] = {
    BufferType = {
        provider = function()
            return buffer.get_buffer_filetype() ~= '' and buffer.get_buffer_filetype() or 'VIM'
        end,
        separator = '',
        separator_highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui },
        highlight = { COLORS.nord3_gui_bright, COLORS.nord1_gui }
    }
}
