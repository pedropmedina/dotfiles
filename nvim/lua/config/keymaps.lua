-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear search highligh on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Paste with overwritting
vim.keymap.set('v', 'p', 'P')

-- Redo with 'U' instead of <C-r>
vim.keymap.set('n', 'U', '<C-r>')

-- Diagnostic keymaps
-- NOTE: Since release 0.10 these two mappings are builtin
-- vim.keymap.set('n', '[d', function() vim.diagnostic.jump { count = 1 } end, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', function() vim.diagnostic.jump { count = -1 } end, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '˚', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '∆', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '˙', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '¬', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })
vim.keymap.set('n', '<Leader>=', '<C-w>=', { desc = 'Set all window to same size.' })

-- Move Lines
vim.keymap.set('n', 'Ô', '<cmd>m .+1<cr>==', { desc = 'Move down' })
vim.keymap.set('n', '', '<cmd>m .-2<cr>==', { desc = 'Move up' })
vim.keymap.set('i', 'Ô', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
vim.keymap.set('i', '', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
vim.keymap.set('v', 'Ô', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('v', '', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
vim.keymap.set('n', '<leader>`', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- Multiple cursors alternative. Under a word or selection replace word with 's*' and repeat instance with '.'
vim.keymap.set('n', 's*', ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn")
vim.keymap.set('x', 's*', '"sy:let @/=@s<CR>cgn')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
vim.keymap.set('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
vim.keymap.set('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
vim.keymap.set('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
vim.keymap.set('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')

-- Save file with <Ctr-S>
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- Keywordprg
vim.keymap.set('n', '<leader>K', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- Better indenting in visual mode with `>` and `<`
vim.keymap.set('v', '<', '< gv')
vim.keymap.set('v', '>', '> gv')

-- Open Lazy
vim.keymap.set('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- New file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New File' })

-- Open quick and local list and navigate both directions
vim.keymap.set('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
vim.keymap.set('n', '<leader>xq', '<cmd>copen<cr>', { desc = 'Quickfix List' })
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })

-- Quit all buffers
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Terminal
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = '[T]erminal enter normal mode' })
vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = '[T]erminal [G]o to left window' })
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = '[T]erminal [G]o to lower window' })
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = '[T]erminal [G]o to upper window' })
vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = '[T]erminal [G]o to right window' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = '[T]erminal [H]ide' })
vim.keymap.set('n', '<Leader>tn', ':tabnew +terminal<CR>', { noremap = true, silent = true, desc = '[T]erminal [O]pen in new tab' })
vim.keymap.set('n', '<Leader>t_', ':new +terminal<CR>', { noremap = true, silent = true, desc = '[T]erminal [O]pen below' })
vim.keymap.set('n', '<Leader>t|', ':vnew +terminal<CR>', { noremap = true, silent = true, desc = '[T]erminal [O]pen side' })

-- Windows
vim.keymap.set('n', '<leader>ww', '<C-W>p', { desc = 'Other window', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete window', remap = true })
vim.keymap.set('n', '<leader>w-', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>w|', '<C-W>v', { desc = 'Split window right', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>_', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split window right', remap = true })

-- Tabs
vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
