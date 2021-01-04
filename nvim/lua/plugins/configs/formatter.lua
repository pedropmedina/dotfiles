local prettier = function()
  return {
    exe = 'prettier',
    args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote' },
    stdin = true
  }
end

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    javascriptreact = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    json = { prettier },
    html = { prettier },
    css = { prettier }
  }
})

vim.cmd([[augroup fmt]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd BufWritePre * Format]])
vim.cmd([[augroup END]])
