local is_treesitter_present, _ = pcall(require, "nvim-treesitter")

local ensured_installed_parsers = {
	"astro",
	"bash",
	"c",
	"css",
	"cmake",
	"comment",
	"dockerfile",
	"diff",
	"dot",
	"elixir",
	"go",
	"graphql",
	"html",
	"json",
	"javascript",
	"lua",
	"markdown",
	"php",
	"prisma",
	"python",
	"rust",
	"tsx",
	"typescript",
	"vim",
	"vue",
	"yaml",
}

if is_treesitter_present then
	require("nvim-treesitter.configs").setup({
		ensure_installed = ensured_installed_parsers,
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = false },
		context_commentstring = { enable = true },
		rainbow = { enable = false },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gis",
				node_incremental = "gni",
				scope_incremental = "gsi",
				node_decremental = "gnd",
			},
		},
		refactor = {
			highlight_definitions = { enable = true },
			highlight_current_scope = { enable = false },
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25,
			persist_queries = false,
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
	})
end
