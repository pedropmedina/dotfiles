return require('packer').startup(
           function()
        -- Packer can manage itself as an optional plugin
        use({ 'wbthomason/packer.nvim', opt = true })

        -- Themes
        use(
            {
                'maaslalani/nordbuddy',
                config = function()
                    require('config/theme')
                end,
                requires = { 'tjdevries/colorbuddy.nvim' }
            }
        )

        -- LSP
        use(
            {
                'kabouzeid/nvim-lspinstall',
                config = function()
                    require('config/lspinstall')
                end,
                requires = {
                    'neovim/nvim-lspconfig',
                    event = 'BufRead',
                    config = function()
                        require('config/lsp')
                    end
                }
            }
        )

        -- Completion & Snippets
        use(
            {
                'hrsh7th/nvim-compe',
                event = 'InsertEnter',
                config = function()
                    require('config/completion')
                end,
                requires = { { 'hrsh7th/vim-vsnip' }, { 'hrsh7th/vim-vsnip-integ' } },
            }
        )

        -- Telescope - dependencies and extensions
        use(
            {
                'nvim-telescope/telescope.nvim',
                config = function()
                    require('config/telescope')
                end,
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
                config = function()
                    require('config/treesitter')
                end
            }
        )
        use({ 'nvim-treesitter/playground', after = 'nvim-treesitter' })
        use({ 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' })
        use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter'})
        use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })

        -- Status line
        use(
            {
                'glepnir/galaxyline.nvim',
                branch = 'main',
                event = 'BufRead',
                config = function()
                    require('config/statusline')
                end
            }
        )

        -- File tree
        use(
            {
                'kyazdani42/nvim-tree.lua',
                cmd = 'NvimTreeToggle',
                config = function()
                    require('config/tree')
                end,
            }
        )

        -- Version control
        use(
            {
                'lewis6991/gitsigns.nvim',
                event = 'BufRead',
                config = function()
                    require('config/gitsigns')
                end
            }
        )

        use({ 'tpope/vim-fugitive' })

        -- Comment text in and out
        use(
            {
                'terrortylor/nvim-comment',
                cmd = 'CommentToggle',
                config = function()
                    require('config/comment')
                end
            }
        )

        use {
            'karb94/neoscroll.nvim',
            event = 'WinScrolled',
            config = function()
                require('neoscroll').setup()
            end
        }

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
