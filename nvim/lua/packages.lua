return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") --> Packer manages itself
	use("nvim-lua/plenary.nvim") --> Neovim utils required by other pkgs
	use("kyazdani42/nvim-web-devicons") --> Icons
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) --> Treesitter (syntax tree)
	use("nvim-treesitter/nvim-treesitter-refactor")
	use("nvim-treesitter/playground")
	use("rktjmp/lush.nvim") --> Theme
	use("~/code/mine/darkside")
	use("nvim-telescope/telescope.nvim") --> Telescope (fuzzy finder)
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-fzf-writer.nvim")
	use("lewis6991/gitsigns.nvim") --> Git gutter signs
	use("nvim-lualine/lualine.nvim") --> Statusline
	use("neovim/nvim-lspconfig") --> Lsp
	use("williamboman/nvim-lsp-installer") --> Lsp intaller (makes it so much easier)
	use("onsails/lspkind-nvim") --> Cool icons on cmp
	use("jose-elias-alvarez/null-ls.nvim") --> Formatting, linting and more ...
	use("hrsh7th/nvim-cmp") --> Completion dropdown
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("windwp/nvim-autopairs") --> Autoclosing ([{''}])
	use("L3MON4D3/LuaSnip") --> Snippets
	use("rafamadriz/friendly-snippets")
	use("numToStr/Comment.nvim") --> Comment code with gc, gcc ...
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("blackCauldron7/surround.nvim") --> Wrap, change, remove content with s, sr, sd
	use("haya14busa/is.vim") --> Remove search highlight (:nohls) on cursor move
end)
