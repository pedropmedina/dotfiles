-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- Install packer if not preset in ~/.local/share/nvim/site/pack/packer/opt
if not packer_exists then
    if vim.fn.input('Download Packer? ( y for yes ) ') ~= 'y' then return end

    local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath('data'))

    vim.fn.mkdir(directory, 'p')

    local out = vim.fn.system(
                    string.format(
                        'git clone %s %s', 'https://github.com/wbthomason/packer.nvim', directory .. '/packer.nvim'
                    )
                )
    print(out)
    print('Downloading packer.nvim...')
    print('(Restart now, then run :PackerInstall and :PackerCompile to configure plugins!)')
    return
end

return require('packer').startup(
           function()
        -- Packer can manage itself as an optional plugin
        use({ 'wbthomason/packer.nvim', opt = true })

        -- Themes
        use({ 'christianchiarulli/nvcode-color-schemes.vim' })
        use({ 'rktjmp/lush.nvim' })

        -- LSP
        use({ 'kabouzeid/nvim-lspinstall', config = [[require('config/lspinstall')]] })
        use({ 'neovim/nvim-lspconfig', config = [[require('config/lsp')]] })

        -- Completion
        use({ 'hrsh7th/nvim-compe', config = [[require('config/completion')]] })

        -- Snippets
        use(
            { 'hrsh7th/vim-vsnip', config = [[require('config/snippets')]], requires = { { 'hrsh7th/vim-vsnip-integ' } } }
        )

        -- Telescope - dependencies and extensions
        use(
            {
                'nvim-telescope/telescope.nvim',
                config = [[require('config/telescope')]],
                requires = {
                    { 'nvim-telescope/telescope-fzy-native.nvim' },
                    { 'nvim-telescope/telescope-fzf-writer.nvim' },
                    { 'nvim-lua/popup.nvim' },
                    { 'nvim-lua/plenary.nvim' }
                }
            }
        )

        -- Treesitter
        use(
            {
                'nvim-treesitter/nvim-treesitter',
                config = [[require('config/treesitter')]],
                requires = {
                    { 'nvim-treesitter/nvim-treesitter-refactor' },
                    { 'nvim-treesitter/playground' },
                    { 'JoosepAlviste/nvim-ts-context-commentstring' },
                    { 'p00f/nvim-ts-rainbow' }
                }
            }
        )

        -- RGB, Hex, ... color highlights
        use({ 'norcalli/nvim-colorizer.lua', config = [[require('config/colorizer')]] })

        -- Status line
        use({ 'glepnir/galaxyline.nvim', branch = 'main', config = [[require('config/statusline')]] })

        -- File tree
        use({ 'kyazdani42/nvim-tree.lua', config = [[require('config/tree')]] })

        -- Version control
        use({ 'lewis6991/gitsigns.nvim', config = [[require('config/gitsigns')]] })
        use({ 'tpope/vim-fugitive' })

        -- Comment text in and out
        use({ 'terrortylor/nvim-comment', config = [[require('config/comment')]] })

        -- Indentation lines - DISABLED for now (It can get pretty slow in large files)
        use(
            {
                'lukas-reineke/indent-blankline.nvim',
                branch = 'lua',
                config = [[require('config/indentation')]],
                disable = true
            }
        )

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
