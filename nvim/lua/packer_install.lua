-- Only required if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- Install packer if not preset in ~/.local/share/nvim/site/pack/packer/opt
if not packer_exists then
    if vim.fn.input('Download Packer? ( y for yes ) ') ~= 'y' then return end

    local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath('data'))

    vim.fn.mkdir(directory, 'p')

    local out = vim.fn.system(
                    string.format(
                        'git clone %s %s', 'https://github.com/wbthomason/packer.nvim',
                        directory .. '/packer.nvim'
                    )
                )

    print(out)
    print('Downloading packer.nvim...')
    print('(Restart now, then run :PackerInstall and :PackerCompile!)')

    return false
end

return true
