local finders = {}

-- find files
finders.find_files = function()
	local opts = {
		find_command = {
			"fd",
			"--hidden",
			"--follow",
			"--type",
			"file",
			"--exclude",
			".git",
			"--exclude",
			"node_modules",
		},
		-- previewer = false,
	}
	require("telescope.builtin").find_files(opts)
end

-- find files in dotfiles dir
finders.find_dotfiles = function()
	local opts = {
		cwd = "~/dotfiles",
		prompt_title = "~ dotfiles ~",
		shorten_path = false,
	}
	require("telescope.builtin").find_files(opts)
end

-- rg
finders.live_grep = function()
	require("telescope.builtin").live_grep()
end

-- rg string under the cursor
finders.grep_string = function()
	require("telescope.builtin").grep_string()
end

-- list buffers
finders.buffers = function()
	require("telescope.builtin").buffers()
end

-- current buffer lines
finders.current_buffer_fuzzy_find = function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end

return finders
