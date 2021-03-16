-- Custom finders
local finders = {}

-- Dropdown list theme using a builtin theme definations :
-- local center_list = require'telescope.themes'.get_dropdown({
--   winblend = 2,
--   width = 0.85,
--   prompt_prefix = ' > ',
--   results_height = 45,
--   previewer = false,
--   find_command = { 'fd',  '--hidden',  '--follow', '--type', 'file', '--exclude', '.git' },
-- })

-- find files
finders.find_files = function()
  local opts = {
    find_command = { 'fd',  '--hidden',  '--follow', '--type', 'file', '--exclude', '.git' }
  }
  require('telescope.builtin').find_files(opts)
end

-- find files in dotfiles dir
finders.find_dotfiles = function()
  -- local opts = vim.deepcopy(center_list)
  local opts = {}
  opts.cwd = '~/dotfiles'
  opts.prompt_title = '~ dotfiles ~'
  opts.shorten_path = false
  require'telescope.builtin'.find_files(opts)
end

-- rg
finders.live_grep = function()
  -- local opts = vim.deepcopy(center_list)
  require'telescope.builtin'.live_grep()
end

-- rg string under the cursor
finders.grep_string = function()
  require'telescope.builtin'.grep_string()
end

-- list buffers
finders.buffers = function()
  -- local opts = vim.deepcopy(center_list)
  require'telescope.builtin'.buffers()
end

-- current buffer lines
finders.current_buffer_fuzzy_find = function()
  -- local opts = vim.deepcopy(center_list)
  require'telescope.builtin'.current_buffer_fuzzy_find()
end

return finders
