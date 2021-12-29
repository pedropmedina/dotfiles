-- Moving to null-ls.nvim to handle linting and formatting - Leave here for reference
-- https://github.com/mattn/efm-langserver
local efm = function(config)
	-- https://github.com/johnnymorganz/stylua
	local stylua = { formatCommand = [[ stylua -s --stdin-filepath ${INPUT} - ]], formatStdin = true }

	-- https://prettier.io/
	local prettier = {
		formatCommand = ([[
            $([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier")
            --stdin-filepath ${INPUT}
            ${--config-precedence:configPrecedence}
            --config-precedence prefer-file
            --tab-width 2
            --single-quote
            --print-width 100
            ]]):gsub("\n", " "),
		formatStdin = true,
	}

	-- https://eslint.org/
	local eslint_bin = "./node_modules/.bin/eslint"
	local eslint = {
		lintCommand = eslint_bin .. " -f visualstudio --stdin --stdin-filename ${INPUT}",
		lintIgnoreExitCode = true,
		lintStdin = true,
		lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %trror %m" },
	}

	local opts = {
		init_options = { documentFormatting = true },
		root_dir = vim.loop.cwd,
		filetypes = {
			"lua",
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"html",
			"css",
			"scss",
			"json",
			"yaml",
			"markdown",
			"vue",
		},
		settings = {
			rootMarkers = { ".git/", "package.json" },
			languages = {
				lua = { stylua },
				typescript = { prettier, eslint },
				javascript = { prettier, eslint },
				typescriptreact = { prettier, eslint },
				javascriptreact = { prettier, eslint },
				yaml = { prettier },
				json = { prettier },
				html = { prettier },
				scss = { prettier },
				css = { prettier },
				markdown = { prettier },
				vue = { prettier },
			},
		},
	}

	for k, v in pairs(config) do
		opts[k] = v
	end
	return opts
end

return efm
