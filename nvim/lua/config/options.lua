-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- See `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 300

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 500

-- Time in milliseconds to wait for a key code sequence to complete
vim.opt.ttimeoutlen = 0

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = vim.opt.listchars - 'space' - 'trail' - 'lead' - 'nbsp' - 'tab'
vim.cmd [[set listchars+=tab:\ \ ,eol:¬,extends:…,precedes:…]]

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- A comma-separated list of options for Insert mode completion
vim.opt.completeopt = 'menu,menuone,noselect'

-- Hide * markup for bold and italic
vim.opt.conceallevel = 3

-- Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- In Insert mode: Use the appropriate number of spaces to insert a <Tab>
vim.opt.expandtab = true

-- Don't start comment line before/after prev line
vim.opt.formatoptions = vim.opt.formatoptions - 'c' - 'r' - 'o'

-- Program and format to use for the :grep
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'

-- Don't show partial off-screen results in a preview window
vim.opt.inccommand = 'nosplit'

-- Always and ONLY show status line for the last window
vim.opt.laststatus = 3

-- Push the command line prompt to the bottom
vim.opt.cmdheight = 0

-- Round indent to multiple of 'shiftwidth'.  Applies to > and < commands.
vim.opt.shiftround = true
vim.opt.shiftwidth = 2

-- Simplify how we get messages
vim.opt.shortmess = 'aoOTcF'

-- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set
vim.opt.sidescrolloff = 8

-- Insert indents automatically
vim.opt.smartindent = true

-- Enable English spelling
vim.opt.spelllang = { 'en' }

-- Keep the text on the same screen line when opening, closing or resizing horizontal splits.
vim.opt.splitkeep = 'screen'

-- Number of spaces tabs count for
vim.opt.tabstop = 2

-- True color support
vim.opt.termguicolors = true

-- Allow cursor to move where there is no text in visual block mode
vim.opt.virtualedit = 'block'

-- Command-line completion mode
vim.opt.wildmode = 'longest:full,full'

-- Minimum window width
vim.opt.winminwidth = 5

-- Disable line wrap
vim.opt.wrap = false

-- Show tabline if more than tab is present
vim.opt.showtabline = 1
