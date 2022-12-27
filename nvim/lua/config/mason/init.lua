local ensure_installed_servers = {
	"astro",
	"bashls",
	"cmake",
	"cssls",
	"dockerls",
	"dotls",
	"elixirls",
	"gopls",
	"graphql",
	"html",
	"jsonls",
	"prismals",
	"sumneko_lua",
	"rust_analyzer",
	"tailwindcss",
	"tsserver",
	"vimls",
	"vuels",
	"yamlls",
	"intelephense",
}

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = ensure_installed_servers })
require("config.mason.lsp_config")
require("config.mason.lsp_mappings")
require("config.mason.format_and_lint")
