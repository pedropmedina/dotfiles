-- Defaults
-- NOTE: I have to dig deeper here as not all the defult provided in the docs are applied
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

require('telescope').setup{
  defaults = {
    prompt_position = 'top',
    prompt_prefix = ' > ',
    sorting_strategy = 'ascending',
    winblend = 2,
    borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
    layout_strategy = 'horizontal',
    scroll_strategy = 'cycle',
    mappings = {
      i = {
        ["<c-x>"] = false,
        ["<c-s>"] = actions.goto_file_selection_split,
      },
    },
    file_sorter = sorters.get_fzy_sorter,
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    },
  }
}

-- Higlights
vim.cmd([[ hi TelescopeBorder guifg=#363a42 ]])