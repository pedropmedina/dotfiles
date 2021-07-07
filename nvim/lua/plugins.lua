return require('packer').startup(
           function()
        -- Packer can manage itself as an optional plugin
        use({ 'wbthomason/packer.nvim', opt = true })

        use { 'pedropmedina/darkside', requires = { 'rktjmp/lush.nvim' } }

        -- LSP
        use(
            {
                'kabouzeid/nvim-lspinstall',
                config = require('config/lsp'),
                requires = { 'neovim/nvim-lspconfig', event = 'BufRead' }
            }
        )

        -- Completion & Snippets
        use(
            {
                'hrsh7th/nvim-compe',
                event = 'InsertEnter',
                config = require('config/completion'),
                requires = {
                    { 'hrsh7th/vim-vsnip', config = require('config/snippets') },
                    { 'hrsh7th/vim-vsnip-integ' }
                }
            }
        )

        -- Telescope - dependencies and extensions
        use(
            {
                'nvim-telescope/telescope.nvim',
                config = require('config/telescope'),
                requires = {
                    { 'nvim-lua/plenary.nvim' },
                    { 'nvim-lua/popup.nvim' },
                    { 'nvim-telescope/telescope-fzy-native.nvim' },
                    { 'nvim-telescope/telescope-fzf-writer.nvim' }
                }
            }
        )

        -- Treesitter
        use(
            {
                'nvim-treesitter/nvim-treesitter',
                event = 'BufRead',
                config = require('config/treesitter')
            }
        )
        use({ 'nvim-treesitter/playground', after = 'nvim-treesitter' })
        use({ 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' })
        use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' })
        use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })

        -- Status line
        use(
            {
                'glepnir/galaxyline.nvim',
                branch = 'main',
                event = 'BufRead',
                config = require('config/statusline')
            }
        )

        -- File tree
        use({ 'kyazdani42/nvim-tree.lua', cmd = 'NvimTreeToggle', config = require('config/tree') })

        -- Version control
        use({ 'lewis6991/gitsigns.nvim', event = 'BufRead', config = require('config/gitsigns') })

        use({ 'tpope/vim-fugitive' })

        -- Comment text in and out
        use(
            { 'terrortylor/nvim-comment', cmd = 'CommentToggle', config = require('config/comment') }
        )

        -- Icons
        use({ 'kyazdani42/nvim-web-devicons', config = require('config/devicons') })

        -- Better scrolling
        use { 'karb94/neoscroll.nvim', event = 'WinScrolled', config = require('config/scroll') }

        -- Auto pairs for '(' '[' '{'...
        use({ 'windwp/nvim-autopairs', after = 'nvim-compe', config = require('config/autopairs') })

        -- Surround text
        use({ 'tpope/vim-surround' })

        -- Automatically clear highlight ( :nohls )
        use({ 'haya14busa/is.vim' })

        -- Search highlighted text with * or # from a visual block
        use({ 'nelstrom/vim-visual-star-search' })

        -- temp support for .hbs files
        use({ 'mustache/vim-mustache-handlebars' })
    end
       )
