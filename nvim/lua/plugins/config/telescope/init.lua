-- Defaults
-- NOTE: I have to dig deeper here as not all the defult provided in the docs are applied
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob=!node_modules/*'
    },
    prompt_position = 'top',
    prompt_prefix = ' > ',
    sorting_strategy = 'ascending',
    preview_cutoff = 140,
    winblend = 2,
    borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
    layout_strategy = 'horizontal',
    scroll_strategy = 'cycle',
    mappings = {
      i = {
        ["<c-x>"] = false,
        ["<c-s>"] = actions.select_horizontal
      },
    },
    file_sorter = sorters.get_fzy_sorter,
    file_ignore_patterns = { 'node_modules/.*' },
    extensions = {
      fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
      }
    },
  }
}
