-- A blazing fast and easy to configure Neovim statusline written in Lua.
-- https://github.com/nvim-lualine/lualine.nvim

local M = {}

M.setup_options = setmetatable({
  options = {
    component_separators = '',
    section_separators = '',
    globalstatus = true,
    disabled_filetypes = { 'starter', 'TelescopePrompt' },
    theme = {
      normal = {},
      inactive = {},
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { 'quickfix', 'lazy', 'mason', 'oil', 'nvim-dap-ui' },
}, {
  __index = function(t)
    return t
  end,
})


-- stylua: ignore start
M.modes = setmetatable({
  ['n']    = { long = 'Normal',   short = 'N',   fg = 'muted', bg = 'base' },
  ['v']    = { long = 'Visual',   short = 'V',   fg = 'iris',  bg = 'base' },
  ['V']    = { long = 'V-Line',   short = 'V-L', fg = 'iris',  bg = 'base' },
  ['^V']   = { long = 'V-Block',  short = 'V-B', fg = 'iris',  bg = 'base' },
  ['s']    = { long = 'Select',   short = 'S',   fg = 'iris',  bg = 'base' },
  ['S']    = { long = 'S-Line',   short = 'S-L', fg = 'iris',  bg = 'base' },
  ['^S']   = { long = 'S-Block',  short = 'S-B', fg = 'iris',  bg = 'base' },
  ['i']    = { long = 'Insert',   short = 'I',   fg = 'foam',  bg = 'base' },
  ['R']    = { long = 'Replace',  short = 'R',   fg = 'love',  bg = 'base' },
  ['c']    = { long = 'Command',  short = 'C',   fg = 'gold',  bg = 'base' },
  ['r']    = { long = 'Prompt',   short = 'P',   fg = 'rose',  bg = 'base' },
  ['!']    = { long = 'Shell',    short = 'Sh',  fg = 'rose',  bg = 'base' },
  ['t']    = { long = 'Terminal', short = 'T',   fg = 'rose',  bg = 'base' },
}, {
  __index = function()
    return   { long = 'Unknown',  short = 'U',   fg = 'rose', bg = 'base' }
  end,
})
-- stylua: ignore end

M.is_truncated = function(trunc_width)
  -- Use -1 to default to 'not truncated'
  local cur_width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
  return cur_width < (trunc_width or -1)
end

M.is_empty_buffer = function()
  return vim.fn.empty(vim.fn.expand '%:t') == 1
end

M.is_not_empty_buffer = function()
  return M.is_empty_buffer() == false
end

M.get_mode_colors = function()
  local palette = require 'rose-pine.palette'
  local mode = M.modes[vim.fn.mode()]
  return { fg = palette[mode.fg], bg = palette[mode.bg] }
end

M.get_mode_content = function(args)
  local mode = M.modes[vim.fn.mode()]
  local block = '▊'
  return args ~= nil and ((args.show_short_name == true and block .. ' ' .. mode.short) or (args.show_long_name == true and block .. ' ' .. mode.long)) or '▊'
end

M.get_file_size = function()
  local size = vim.fn.getfsize(vim.fn.getreg '%')
  if size < 1024 then
    return string.format('%dB', size)
  elseif size < 1048576 then
    return string.format('%.2fKiB', size / 1024)
  else
    return string.format('%.2fMiB', size / 1048576)
  end
end

-- (/path/to/file.{ext} + <size>)
M.get_file_info = function()
  if M.is_empty_buffer() == true then
    return ''
  end
  return M.get_file_path() .. string.rep(' ', 2) .. M.get_file_size()
end

M.get_file_path = function()
  if vim.bo.buftype == 'terminal' then
    return vim.fn.expand '%t'
  else
    return '~/' .. vim.fn.expand '%:~:.'
  end
end

M.get_lsp_client_name = function()
  local msg = 'No Active Lsp'
  local buf_ft = vim.bo.filetype
  local clients = vim.lsp.get_clients()

  if next(clients) == nil then
    return msg
  end

  -- Get all active clients
  local active_names = {}
  for _, client in ipairs(clients) do
    ---@diagnostic disable-next-line: undefined-field
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      table.insert(active_names, client.name)
    end
  end

  -- Return default message if not client is active
  if next(active_names) == nil then
    return msg
  end

  -- Remove duplicates
  local hash = {}
  local names = {}
  for _, v in ipairs(active_names) do
    if not hash[v] then
      names[#names + 1] = v
      hash[v] = true
    end
  end

  -- Sort list if more than one
  if #names > 1 then
    table.sort(names, function(a, b)
      return a < b
    end)
  end

  -- Limit the size of the string to a max of two names
  if #names > 1 then
    return names[1] .. ',...'
  end

  -- Return name1
  return names[1]
end

M.set_left_section = function(component_options)
  return function()
    table.insert(M.setup_options.sections.lualine_a, component_options)
  end
end

M.set_right_section = function(component_options)
  return function()
    table.insert(M.setup_options.sections.lualine_z, component_options)
  end
end

M.set_theme = function()
  local palette = require 'rose-pine.palette'
  local normal_theme, inactive_theme = {}, {}
  for key in pairs(M.setup_options.sections) do
    normal_theme[key:gsub('lualine_', '')] = { fg = palette.muted, bg = palette.surface }
    inactive_theme[key:gsub('lualine_', '')] = { fg = palette.muted, bg = palette.base }
  end
  M.setup_options.options.theme.normal = normal_theme
  M.setup_options.options.theme.inactive = inactive_theme
end

M.set_section_mode = M.set_left_section {
  function()
    return M.get_mode_content()
  end,
  color = function()
    return M.get_mode_colors()
  end,
  padding = { right = 0 },
}

M.set_section_file_info = M.set_left_section {
  M.get_file_info,
  cond = M.is_not_empty_buffer,
}

M.set_section_diagnostics = M.set_left_section {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = {
    error = 'E',
    warn = 'W',
    info = 'I',
    hint = 'H',
  },
}

M.set_section_branch = M.set_left_section {
  'branch',
  icon = '',
}

M.set_section_diff = M.set_left_section {
  'diff',
  cond = function()
    return M.is_truncated(80) == false
  end,
}

M.set_section_encoding = M.set_right_section {
  'encoding',
  fmt = string.upper,
  cond = function()
    return M.is_truncated(80) == false
  end,
}

M.set_section_searchcount = M.set_right_section {
  'searchcount',
}

M.set_section_lsp = M.set_right_section {
  M.get_lsp_client_name,
  icon = '󰐻',
}

M.set_section_location = M.set_right_section {
  'location',
}

M.set_section_progress = M.set_right_section {
  'progress',
  padding = { left = 0, right = 1 },
}

M.get_setup_options = function()
  M.set_theme()
  M.set_section_mode()
  M.set_section_file_info()
  M.set_section_diagnostics()
  M.set_section_branch()
  M.set_section_diff()
  M.set_section_searchcount()
  M.set_section_lsp()
  M.set_section_encoding()
  M.set_section_location()
  M.set_section_progress()
  return M.setup_options
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'BufRead',
  dependencies = { 'rose-pine' },
  opts = {},
  config = function(_, opts)
    local setup_options = M.get_setup_options()
    local options = vim.tbl_deep_extend('force', opts, setup_options)
    require('lualine').setup(options)
  end,
}
