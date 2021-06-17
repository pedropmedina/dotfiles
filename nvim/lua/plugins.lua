return require('packer').startup(
           function()
        -- Packer can manage itself as an optional plugin
        use({ 'wbthomason/packer.nvim', opt = true })

        -- Themes
        use({ 'rktjmp/lush.nvim' })
        use({ 'tjdevries/colorbuddy.nvim' })
        use({ 'maaslalani/nordbuddy' })

        -- LSP
        use({ 'kabouzeid/nvim-lspinstall' })
        use({ 'neovim/nvim-lspconfig' })
        use({ 'folke/trouble.nvim' })

        -- Completion
        use({ 'hrsh7th/nvim-compe' })

        -- Snippets
        use({ 'hrsh7th/vim-vsnip' })
        use({ 'hrsh7th/vim-vsnip-integ' })

        -- Telescope - dependencies and extensions
        use({ 'nvim-lua/popup.nvim' })
        use({ 'nvim-lua/plenary.nvim' })
        use({ 'nvim-telescope/telescope.nvim' })
        use({ 'nvim-telescope/telescope-fzy-native.nvim' })
        use({ 'nvim-telescope/telescope-fzf-writer.nvim' })

        -- Treesitter
        use({ 'nvim-treesitter/nvim-treesitter' })
        use({ 'nvim-treesitter/nvim-treesitter-refactor' })
        use({ 'nvim-treesitter/playground' })
        use({ 'JoosepAlviste/nvim-ts-context-commentstring' })
        use({ 'p00f/nvim-ts-rainbow' })

        -- Status line
        use({ 'glepnir/galaxyline.nvim', branch = 'main' })

        -- File tree
        use({ 'kyazdani42/nvim-tree.lua' })

        -- Version control
        use({ 'tpope/vim-fugitive' })
        use({ 'lewis6991/gitsigns.nvim' })

        -- Comment text in and out
        use({ 'terrortylor/nvim-comment' })

        -- Surround text
        use({ 'tpope/vim-surround' })

        -- Auto pairs for '(' '[' '{'...
        use({ 'cohama/lexima.vim' })

        -- Automatically clear highlight ( :nohls )
        use({ 'haya14busa/is.vim' })

        -- Search highlighted text with * or # from a visual block
        use({ 'nelstrom/vim-visual-star-search' })

        -- temp support for .hbs files
        use({ 'mustache/vim-mustache-handlebars' })
    end
       )
