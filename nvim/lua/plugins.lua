local function packer_startup_cb()
    -- Packer can manage itself as an optional plugin
    use({ 'wbthomason/packer.nvim', opt = true })

    -- Theme
    --  this is a local plugin, use 'pedropmedina/darkside' instead
    use({ '~/code/mine/darkside', requires = { 'rktjmp/lush.nvim' } })

    -- LSP
    use(
        {
            'kabouzeid/nvim-lspinstall',
            config = require('config.lsp'),
            requires = { 'neovim/nvim-lspconfig', event = 'BufRead' }
        }
    )

    -- Completion & Snippets
    use(
        {
            'hrsh7th/nvim-compe',
            event = 'InsertEnter',
            config = require('config.completion'),
            requires = {
                {
                    'L3MON4D3/LuaSnip',
                    requires = { 'rafamadriz/friendly-snippets' },
                    config = require('config.snippets')
                }
            }
        }
    )

    -- Telescope - dependencies and extensions
    use(
        {
            'nvim-telescope/telescope.nvim',
            config = require('config.telescope'),
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
            config = require('config.treesitter')
        }
    )
    use({ 'nvim-treesitter/playground', after = 'nvim-treesitter' })
    use({ 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' })
    use({ 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' })
    use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter', disable = true })

    -- Status line
    use(
        {
            'glepnir/galaxyline.nvim',
            branch = 'main',
            event = 'BufRead',
            config = require('config.statusline')
        }
    )

    -- File tree
    use(
        {
            'kyazdani42/nvim-tree.lua',
            cmd = 'NvimTreeToggle',
            event = 'BufRead',
            config = require('config.tree')
        }
    )

    -- Change cwd to the project's root
    use({ 'airblade/vim-rooter', config = require('config.rooter'), event = 'BufRead' })

    -- Version control
    use({ 'lewis6991/gitsigns.nvim', event = 'BufRead', config = require('config.gitsigns') })
    use({ 'sindrets/diffview.nvim', event = 'BufRead', config = require('config.diffview') })
    use({ 'TimUntersberger/neogit', event = 'BufRead', config = require('config.neogit') })

    use({ 'tpope/vim-fugitive', cmd = 'Git' })

    -- Comment text in and out
    use({ 'terrortylor/nvim-comment', cmd = 'CommentToggle', config = require('config.comment') })

    -- Icons
    use({ 'kyazdani42/nvim-web-devicons', config = require('config.devicons') })

    -- Better scrolling
    use { 'karb94/neoscroll.nvim', event = 'WinScrolled', config = require('config.scroll') }

    -- Auto pairs for '(' '[' '{'...
    use({ 'windwp/nvim-autopairs', after = 'nvim-compe', config = require('config.autopairs') })

    -- Surround text
    use({ 'tpope/vim-surround', event = 'BufRead' })

    -- Automatically clear highlight ( :nohls )
    use({ 'haya14busa/is.vim', event = 'BufRead' })

    -- Search highlighted text with * or # from a visual block
    use({ 'nelstrom/vim-visual-star-search', event = 'BufRead' })

    -- temp support for .hbs files
    use({ 'mustache/vim-mustache-handlebars', disable = true })
end

return require('packer').startup(packer_startup_cb)
