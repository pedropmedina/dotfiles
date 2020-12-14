-- Remove number column from terminal emulator window
vim.cmd([[augroup cleanup_terminal]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd TermOpen * startinsert]])
vim.cmd([[autocmd TermOpen * set nonumber norelativenumber]])
vim.cmd([[augroup END]])

-- highlight on yank
vim.cmd([[autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup="IncSearch", timeout=400 })]])

-- auto save buffer on leaving
vim.cmd([[autocmd BufLeave * if index(['lua.luapad'], &ft) == -1 | silent! update | endif]])
