-- No sure why options available on more than one scope need to be set on all
-- applicable scopes in order to take effect; e.g. bo.tabstop and o.tabstop
-- Global options
local global_options = {
    termguicolors = true,
    encoding = 'utf-8',
    fileencoding = 'utf-8',
    t_Co = '256',
    background = 'dark',
    ruler = true,
    laststatus = 2,
    showtabline = 1,
    pumheight = 15,
    splitbelow = true,
    splitright = true,
    hidden = true,
    cmdheight = 1,
    mouse = 'a',
    smarttab = true,
    smartindent = true,
    showmode = false,
    backup = false,
    writebackup = false,
    swapfile = false,
    updatetime = 300,
    timeoutlen = 500,
    ttimeoutlen = 0,
    clipboard = 'unnamedplus',
    ignorecase = true,
    smartcase = true,
    incsearch = true,
    completeopt = 'menuone,noinsert,noselect',
    shortmess = 'aoOTcF',
    autowriteall = true,
    autoindent = true,
    expandtab = true,
    tabstop = 2,
    shiftwidth = 2,
    scrolloff = 8,
    guifont = 'Victor\\ Mono',
    syntax = 'on'
}

-- Buffer options
local buffer_options = {
    synmaxcol = 2500,
    autoindent = true,
    expandtab = true,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = -1,
    swapfile = false
}

-- Set window options
local window_options = {
    number = true,
    relativenumber = true,
    cursorline = true,
    signcolumn = 'yes',
    conceallevel = 0,
    linebreak = true,
    wrap = false,
    breakindentopt = 'shift:2,min:20'
}

local function set_options(options, scope)
    for name, value in pairs(options) do vim[scope][name] = value end
end

set_options(global_options, 'go')
set_options(buffer_options, 'bo')
set_options(window_options, 'wo')

-- enable embeded lua highlighting
vim.g.vimsyn_embed = 'l'

-- disable some of the built in plugins
local function disable_distribution_plugins()
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    -- vim.g.loaded_matchit           = 1
    -- vim.g.loaded_matchparen        = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
end

disable_distribution_plugins()
