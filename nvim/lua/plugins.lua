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

vim.g.nord_italic = false

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
