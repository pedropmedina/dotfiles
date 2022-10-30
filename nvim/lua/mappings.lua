local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.keymap.set("n", " ", "", opts)
vim.keymap.set("x", " ", "", opts)

-- Indentation
vim.keymap.set("v", "<", "< gv", opts)
vim.keymap.set("v", ">", "> gv", opts)

-- Save and quit files mapper('n', '<Leader>w', ':w!<CR>')
vim.keymap.set("n", "<Leader>w", ":w!<CR>", opts)
vim.keymap.set("n", "<Leader>wq", ":wq!<CR>", opts)
vim.keymap.set("n", "<Leader>q", ":confirm wqa!<CR>", opts)

-- Find and Replace selected words in normal/visual mode with *
vim.keymap.set("x", "<Leader>fr", ":%s///g<Left><Left>", opts)

-- Multiple cursors alternative. Under a word or selection replace word with 's*' and repeat instance with '.'
vim.keymap.set("n", "s*", ":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn", opts)
vim.keymap.set("x", "s*", '"sy:let @/=@s<CR>cgn', opts)

-- Current window split horizontally, vertically, equal size
vim.keymap.set("n", "<Leader>_", "<C-w>s", opts)
vim.keymap.set("n", "<Leader>|", "<C-w>v", opts)
vim.keymap.set("n", "<Leader>=", "<C-w>=", opts)

-- Normal mode window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Insert mode navigation
vim.keymap.set("i", "<C-h>", "<Esc><C-w>h", opts)
vim.keymap.set("i", "<C-j>", "<Esc><C-w>j", opts)
vim.keymap.set("i", "<C-k>", "<Esc><C-w>k", opts)
vim.keymap.set("i", "<C-l>", "<Esc><C-w>l", opts)

-- Terminal window navigation
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", opts)
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- Buffers navigation
vim.keymap.set("n", "<Leader>bl", ":bnext<CR>", opts)
vim.keymap.set("n", "<Leader>bh", ":bprevious<CR>", opts)
vim.keymap.set("n", "<Leader>bq", ":bdelete<CR>", opts)

-- Tabs navigation
vim.keymap.set("n", "<Leader>tn", ":tabnew %<CR>", opts)
vim.keymap.set("n", "<Leader>tl", ":tabnext<CR>", opts)
vim.keymap.set("n", "<Leader>th", ":tabprevious<CR>", opts)
vim.keymap.set("n", "<Leader>tq", ":tabclose<CR>", opts)

-- Work around for using alt key to resize widows on mac
vim.keymap.set("n", "˚", ":resize -2<CR>", opts)
vim.keymap.set("n", "∆", ":resize +2<CR>", opts)
vim.keymap.set("n", "˙", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "¬", ":vertical resize +2<CR>", opts)

-- Opening new terminal emulators
vim.keymap.set("n", "<Leader>tt", ":tabnew +terminal<CR>", opts)
vim.keymap.set("n", "<Leader>ts", ":new +terminal<CR>", opts)
vim.keymap.set("n", "<Leader>tv", ":vnew +terminal<CR>", opts)
