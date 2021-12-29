local present, lsp_installer = pcall(require, "nvim-lsp-installer")

if present then
	local lsp_installer_servers = require("nvim-lsp-installer.servers")
	local common_setup = require("config.lsp.common_setup")

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

	-- Setup all servers installed via nvim-lsp-installer
	local function setup_servers(setups)
		lsp_installer.on_server_ready(function(server)
			server:setup(setups[server.name] or {})
			vim.cmd([[ do User LspAttachBuffers ]])
		end)

		require("config.lsp.servers.null_ls")(common_setup)
	end

	local setups = {
		sumneko_lua = require("config.lsp.servers.lua")(common_setup),
		vimls = require("config.lsp.servers.vim")(common_setup),
		bashls = require("config.lsp.servers.bash")(common_setup),
		rust_analyzer = require("config.lsp.servers.rust")(common_setup),
		gopls = require("config.lsp.servers.go")(common_setup),
		html = require("config.lsp.servers.html")(common_setup),
		cssls = require("config.lsp.servers.css")(common_setup),
		jsonls = require("config.lsp.servers.json")(common_setup),
		vuels = require("config.lsp.servers.vue")(common_setup),
		tsserver = require("config.lsp.servers.typescript")(common_setup),
		dockerls = require("config.lsp.servers.dockerfile")(common_setup),
		tailwindcss = require("config.lsp.servers.tailwindcss")(common_setup),
		intelephense = require("config.lsp.servers.php")(common_setup),
	}

	install_servers(vim.tbl_keys(setups))
	setup_servers(setups)
end
