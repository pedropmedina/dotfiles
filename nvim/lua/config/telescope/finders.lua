local finders = {}

-- find files
finders.find_files = function()
	local opts = {
		find_command = {
			"fd",
			"--hidden",
			-- "--no-ignore",
			"--follow",
			"--type",
			"file",
			"--exclude",
			".git",
			"--exclude",
			"node_modules",
			"--exclude",
			"dist",
		},
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

return finders
