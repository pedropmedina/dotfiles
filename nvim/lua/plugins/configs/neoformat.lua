vim.g.neoformat_try_formatprg = 1
vim.g.neoformat_basic_format_align = 0
vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_basic_format_trim = 1
vim.g.neoformat_run_all_formatters = 1
vim.g.neoformat_only_msg_on_error = 1

vim.cmd([[augroup fmt]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd BufWritePre * Neoformat]])
vim.cmd([[augroup END]])
