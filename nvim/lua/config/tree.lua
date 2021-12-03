local tree_cb = require("nvim-tree.config").nvim_tree_callback

-- vim.g.nvim_tree_indent_markers = 1
-- vim.g.nvim_tree_hide_dotfiles = 0
-- vim.g.nvim_tree_git_hl = 0
-- vim.g.nvim_tree_gitignore = 0
-- vim.g.nvim_tree_root_folder_modifier = ":t"
-- vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
-- vim.g.nvim_tree_show_icons = { git = 0, files = 1, folders = 1 }
-- vim.g.nvim_tree_icons = {
-- 	default = "",
-- 	symlink = "",
-- 	git = { unstaged = "•", staged = "•", unmerged = "≠", renamed = "•", untracked = "•" },
-- 	folder = { default = "+", open = "-", empty = "+", empty_open = "-" },
-- 	lsp = { hint = "•", info = "•", warning = "•", error = "•" },
-- }

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = false,
	open_on_tab = false,
	update_to_buf_dir = {
		enable = false,
		auto_open = true,
	},
	hijack_cursor = false,
	update_cwd = true,
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = { ".git", "node_modules", ".cache" },
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = false,
	},
	view = {
		width = 35,
		height = 35,
		side = "left",
		auto_resize = false,
		number = false,
		relativenumber = false,
		mappings = {
			custom_only = false,
			list = {
				{ key = "l", cb = tree_cb("edit") },
				{ key = "<C-s>", cb = tree_cb("split") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "!", cb = tree_cb("toggle_ignored") },
				{ key = ".", cb = tree_cb("toggle_dotfiles") },
			},
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})
