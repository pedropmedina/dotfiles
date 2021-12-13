-- Only required if you have packer configured as `opt`
-- Move packer to the /site/pack/packer/start and remove this line!
vim.cmd([[packadd packer.nvim]])

local function packer_startup_cb(use)
	-- Packer can manage itself as an optional plugin
	use({ "wbthomason/packer.nvim", opt = true })

	-- Theme
	--  this is a local plugin, use 'pedropmedina/darkside' instead
	use({ "~/code/mine/darkside", requires = { "rktjmp/lush.nvim" } })

	-- Dependencies
	use({ "nvim-lua/plenary.nvim" })
	use({ "nvim-lua/popup.nvim" })

	-- Completion and sources
	use({
		"hrsh7th/nvim-cmp",
		event = "BufRead",
		config = function()
			require("config.completion")
		end,
		requires = {
			{ "onsails/lspkind-nvim" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
		},
	})

	-- LSP
	use({
		"williamboman/nvim-lsp-installer",
		event = "BufRead",
		config = function()
			require("config.lsp")
		end,
		requires = { { "neovim/nvim-lspconfig" } },
	})

	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "neovim/nvim-lspconfig" } })

	-- Auto pairs for '(' '[' '{'...
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("config.autopairs")
		end,
	})

	-- Snippets
	use({
		{
			"L3MON4D3/LuaSnip",
			config = function()
				require("config.snippets")
			end,
		},
		{ "rafamadriz/friendly-snippets" },
	})

	-- Fuzzy Finder
	use({
		{
			"nvim-telescope/telescope.nvim",
			config = function()
				require("config.telescope")
			end,
		},
		{ "nvim-telescope/telescope-fzy-native.nvim" },
		{ "nvim-telescope/telescope-fzf-writer.nvim" },
	})

	-- Treesitter
	use({
		{
			"nvim-treesitter/nvim-treesitter",
			event = "BufRead",
			config = function()
				require("config.treesitter")
			end,
		},
		{ "nvim-treesitter/playground", after = "nvim-treesitter" },
		{ "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
		{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
	})

	-- Status line
	use({
		"glepnir/galaxyline.nvim",
		branch = "main",
		event = "BufRead",
		config = function()
			require("config.statusline")
		end,
	})

	-- Version control
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("config.gitsigns")
		end,
	})

	-- Comment text in and out
	use({
		"terrortylor/nvim-comment",
		cmd = "CommentToggle",
		config = function()
			require("config.comment")
		end,
	})

	-- Icons
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("config.devicons")
		end,
	})

	-- Surround text
	use({ "tpope/vim-surround", event = "BufRead" })

	-- Automatically clear highlight ( :nohls )
	use({ "haya14busa/is.vim", event = "BufRead" })

	-- Search highlighted text with * or # from a visual block
	use({ "nelstrom/vim-visual-star-search", event = "BufRead" })

	-- temp support for .hbs files
	use({ "mustache/vim-mustache-handlebars", event = "BufRead", disable = true })
end

return require("packer").startup(packer_startup_cb)
