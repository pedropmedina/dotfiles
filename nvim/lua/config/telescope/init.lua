local present, telescope = pcall(require, "telescope")

if present then
	local actions = require("telescope.actions")
	local sorters = require("telescope.sorters")
	local previewers = require("telescope.previewers")

	local setup = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--glob=!node_modules/*",
			},
			mappings = {
				i = {
					["<c-s>"] = actions.select_horizontal,
					["œ"] = actions.send_selected_to_qflist,
				},
			},
			layout_config = { prompt_position = "top", preview_cutoff = 140 },
			prompt_prefix = "  ",
			selection_caret = "  ",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			winblend = 2,
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			layout_strategy = "horizontal",
			scroll_strategy = "cycle",
			file_sorter = sorters.get_fzy_sorter,
			file_ignore_patterns = { "node_modules/.*", ".git/.*", "yarn.lock" },
			file_previewer = previewers.vim_buffer_cat.new,
			grep_previewer = previewers.vim_buffer_vimgrep.new,
			qflist_previewer = previewers.vim_buffer_qflist.new,
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
				fzf_writer = {
					minimum_grep_characters = 2,
					minimum_files_characters = 2,
					use_highlighter = false,
				},
			},
		},
	}

	telescope.setup(setup)
	telescope.load_extension("fzy_native")
	telescope.load_extension("file_browser")
	require("config.telescope.mappings")
end
