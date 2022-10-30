local is_lspconfig_present, lspconfig = pcall(require, "lspconfig")

-- Lsp configurations
if is_lspconfig_present then
	require("mason-lspconfig").setup_handlers({
		-- Apply default setups to most installed servers
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
		-- Override some certain servers
		["cssls"] = function()
			lspconfig.cssls.setup({
				settings = {
					css = { validate = false },
				},
			})
		end,
		["html"] = function()
			lspconfig.html.setup({
				filetypes = { "html", "tsx", "jsx", "vue" },
			})
		end,
		["sumneko_lua"] = function()
			lspconfig.sumneko_lua.setup({
				settings = {
					Lua = {
						format = { enable = false },
						runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
						diagnostics = { enable = true, globals = { "vim", "use", "cmp", "packer_plugins" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
						},
					},
				},
			})
		end,
		["tailwindcss"] = function()
			lspconfig.tailwindcss.setup({
				settings = {
					includeLanguages = {
						typescript = "javascript",
						typescriptreact = "javascript",
					},
					tailwindCSS = {
						experimental = {
							classRegex = {
								"tw`([^`]*)",
								'tw="([^"]*)',
								'tw={"([^"}]*)',
								"tw\\.\\w+`([^`]*)",
								"tw\\(.*?\\)`([^`]*)",
							},
						},
					},
				},
			})
		end,
		["tsserver"] = function()
			lspconfig.tsserver.setup({
				commands = {
					OrganizeImports = {
						description = "Organize Imports",
						function()
							vim.lsp.buf.execute_command({
								title = "",
								command = "_typescript.organizeImports",
								arguments = { vim.api.nvim_buf_get_name(0) },
							})
						end,
					},
				},
			})
		end,
	})
end
