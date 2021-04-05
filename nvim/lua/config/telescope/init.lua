-- Defaults
-- NOTE: I have to dig deeper here as not all the defult provided in the docs are applied
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

require('telescope').setup {
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
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        preview_cutoff = 140,
        winblend = 5,
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        layout_strategy = 'horizontal',
        scroll_strategy = 'cycle',
        mappings = { i = { ['<c-x>'] = false, ['<c-s>'] = actions.select_horizontal } },
        file_sorter = sorters.get_fzy_sorter,
        file_ignore_patterns = { 'node_modules/.*', '.git/.*' },
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        extensions = {
            fzy_native = { override_generic_sorter = false, override_file_sorter = true },
            fzf_writer = { minimum_grep_characters = 2, minimum_files_characters = 2, use_highlighter = false }
        }
    }
}

-- Load extensions
pcall(require('telescope').load_extension, 'fzy_native')
