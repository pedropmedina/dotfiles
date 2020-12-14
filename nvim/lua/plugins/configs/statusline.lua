local galaxyline = require('galaxyline')
local buffer = require('galaxyline.provider_buffer')
local vcs = require('galaxyline.provider_vcs')
local section = galaxyline.section

galaxyline.short_line_list = { 'LuaTree', 'vista', 'dbui' }

-- Constants
local COLORS = {
  bg = '#282c34',
  white = '#abb2bf',
  black = '#282c34 ',
  darkblue = '#242830',
  lightyellow = '#e5c07b',
  darkyellow = '#d19a66',
  lightred = '#e06c75',
  darkred = '#be5046',
  blue = '#61afef',
  mangenta = '#c678dd',
  cyan = '#56b6c2',
  green = '#98c379',
  lightgrey = '#c0c0c0',
  mediumgrey = '#5c6370',
  darkgrey = '#2e323a'
}

local MODE_COLORS = {
  n = COLORS.green,
  i = COLORS.blue,
  c = COLORS.darkred,
  R = COLORS.cyan,
  t = COLORS.mangenta,
  S = COLORS.darkyellow,
  s = COLORS.darkyellow,
  V = COLORS.darkyellow,
  v = COLORS.darkyellow,
  [''] = COLORS.darkyellow
}

local MODE_TEXTS = {
  n = ' NORMAL ',
  i = ' INSERT ',
  c = ' COMMAND ',
  R = 'REPLACE',
  t = ' TERMINAL ',
  S = ' SELECT ',
  s = ' SELECT ',
  V = ' VISUAL ',
  v = ' VISUAL ',
  [''] = ' VISUAL '
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

-- Get project's root dit based on .git or fallback to ~
local root_path = function()
  local git_dir_path = vcs.get_git_dir(vim.fn.expand('%:p:h'))
  return not git_dir_path and vim.fn.expand('%:~') or '...'..vim.fn.expand('%:p'):sub(git_dir_path:len() - 4 )
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

-- local has_item = function(item, list)
--   for _, i in ipairs(list) do
--     if i == item then do return true end
--     return false
--   end
-- end
-- end

section.left[1] = {
  BlockIndicator = {
    provider = function()
      vim.api.nvim_command('hi GalaxyBlockIndicator guibg='..MODE_COLORS[vim.fn.mode()])
      vim.api.nvim_command('hi GalaxyViMode guifg='..MODE_COLORS[vim.fn.mode()])
      return ' '
    end,
    highlight = { COLORS.lightgrey, COLORS.blue }
  },
}

section.left[2] = {
  BlockSeparator = {
    provider = function() return ' ' end,
    highlight = { COLORS.lightgrey, COLORS.darkgrey }
  },
}

section.left[3] = {
  ViMode = {
    provider = function()
      return MODE_TEXTS[vim.fn.mode()]
    end,
    highlight = { COLORS.white, COLORS.darkgrey },
  },
}

section.left[4] = {
  ViModeSeparator = {
    provider = function() return '| ' end,
    condition = buffer_not_empty,
    highlight = { COLORS.darkblue, COLORS.darkgrey },
  },
}

section.left[5] = {
  FileName = {
    condition = buffer_not_empty,
    provider = root_path,
    separator = ' ',
    separator_highlight = { COLORS.darkblue, COLORS.darkgrey },
    highlight = { COLORS.mediumgrey, COLORS.darkgrey }
  }
}


section.left[6] = {
  ModBuffer = {
    provider = function() return vim.bo.mod and '[+] ' or '' end,
    highlight = { COLORS.green, COLORS.darkgrey }
  }
}


section.left[7] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '• ',
    highlight = { COLORS.white, COLORS.bg }
  }
}

section.left[8] = {
  DiagnosticSepartor1 = {
    provider = function () return ' ' end
  }
}

section.left[9] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '• ',
    highlight = { COLORS.darkred, COLORS.bg }
  }
}

section.left[10] = {
  DiagnosticSepartor2 = {
    provider = function () return ' ' end
  }
}

section.left[11] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '• ',
    highlight = { COLORS.darkyellow, COLORS.bg},
  }
}

section.right[1] = {
  GitBranch = {
    provider = function() return '⠕ '..vcs.get_git_branch() end,
    condition = function()
      return buffer.get_buffer_filetype() ~= '' and vcs.check_git_workspace() and vcs.get_git_branch()
    end,
    separator = ' ',
    separator_highlight = { COLORS.darkblue, COLORS.darkgrey},
    highlight = { COLORS.white, COLORS.darkgrey },
  }
}

section.right[2] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '+',
    highlight = { COLORS.green, COLORS.darkgrey },
  }
}

section.right[3] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '~',
    highlight = { COLORS.darkyellow, COLORS.darkgrey },
  }
}

section.right[4] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '-',
    highlight = { COLORS.darkred, COLORS.darkgrey },
  }
}

section.right[5] = {
  GitSeparator = {
    condition = function()
      return buffer.get_buffer_filetype() ~= '' and vcs.check_git_workspace()
    end,
    provider = function() return ' |' end,
    highlight = { COLORS.darkblue, COLORS.darkgrey }
  },
}

section.right[6]= {
  FileFormat = {
    provider = 'FileFormat',
    separator = ' ',
    separator_highlight = { COLORS.darkblue, COLORS.darkgrey },
    highlight = { COLORS.lightgrey, COLORS.darkgrey },
  }
}

section.right[7] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = { COLORS.darkblue, COLORS.darkgrey },
    highlight = { COLORS.lightgrey, COLORS.darkgrey },
  },
}

section.right[8] = {
  Space4 = {
    provider = function () return ' ' end,
    highlight = { COLORS.lightgrey, COLORS.darkgrey },
  }
}

section.right[9] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = { COLORS.darkblue, COLORS.darkblue},
    highlight = { COLORS.lightgrey, COLORS.darkblue},
  }
}

section.short_line_left[1] = {
  Space5 = {
    provider = function () return ' ' end,
    highlight = { COLORS.darkblue, COLORS.darkblue },
  }
}

section.short_line_left[2] = {
  BufferType = {
    provider = function()
      return buffer.get_buffer_filetype() ~= "" and buffer.get_buffer_filetype() or 'VIM'
    end ,
    separator = '',
    separator_highlight = { COLORS.white, COLORS.darkblue },
    highlight = { COLORS.white, COLORS.darkblue }
  }
}
