-- if not require("utils.has_loaded")("cmp-nvim-lsp") then return end

local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require("nvim-lsp-installer.servers")
local common_setup = require("config.lsp.common_setup")
require("config.lsp.handlers")
require("config.lsp.diagnostics")
require("config.lsp.formatting")

local function install_servers(servers)
	for _, server_name in pairs(servers) do
		local ok, server = lsp_installer_servers.get_server(server_name)
		if ok then
			if not server:is_installed() then
				server:install()
			end
		end
	end
end

local function setup_servers(setups)
	-- Setup all servers installed via nvim-lsp-installer
	lsp_installer.on_server_ready(function(server)
		server:setup(setups[server.name] or {})
		vim.cmd([[ do User LspAttachBuffers ]])
	end)

	-- Setup null-ls -> Buggy - Switch back to efm for now handle formatting
	-- require("config.lsp.setups.null_ls")(common_setup)
end

local setups = {
	sumneko_lua = require("config.lsp.setups.lua")(common_setup),
	vimls = require("config.lsp.setups.vim")(common_setup),
	bashls = require("config.lsp.setups.bash")(common_setup),
	rust_analyzer = require("config.lsp.setups.rust")(common_setup),
	gopls = require("config.lsp.setups.go")(common_setup),
	html = require("config.lsp.setups.html")(common_setup),
	cssls = require("config.lsp.setups.css")(common_setup),
	jsonls = require("config.lsp.setups.json")(common_setup),
	vuels = require("config.lsp.setups.vue")(common_setup),
	tsserver = require("config.lsp.setups.typescript")(common_setup),
	dockerls = require("config.lsp.setups.dockerfile")(common_setup),
	tailwindcss = require("config.lsp.setups.tailwindcss")(common_setup),
	intelephense = require("config.lsp.setups.php")(common_setup),
	efm = require("config.lsp.setups.efm")(common_setup),
}

install_servers(vim.tbl_keys(setups))
setup_servers(setups)
