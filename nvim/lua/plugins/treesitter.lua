-- Highlight, edit, and navigate code
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',

    config = function()
      local ts = require 'nvim-treesitter'
      ts.setup { install_dir = vim.fn.stdpath 'data' .. '/site' }
      ts.install {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'javascript',
        'typescript',
        'tsx',
        'jsdoc',
        'json',
        'python',
        'go',
        'java',
        'kotlin',
      }

      vim.treesitter.language.register('json', 'jsonc')
      vim.treesitter.language.register('tsx', 'typescriptreact')
      vim.treesitter.language.register('javascript', 'javascriptreact')
      vim.treesitter.language.register('kt', 'kotlin')

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        pattern = {
          'bash',
          'sql',
          'c',
          'diff',
          'html',
          'lua',
          'luadoc',
          'markdown',
          'vim',
          'vimdoc',
          'javascript',
          'typescript',
          'typescriptreact',
          'javascriptreact',
          'json',
          'jsonc',
          'python',
          'go',
          'java',
          'kotlin',
        },
        callback = function(args)
          local bufnr = args.buf

          pcall(vim.treesitter.start, bufnr)

          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldlevel = 99
        end,
      })

      vim.api.nvim_create_user_command('TSResetHighlight', function()
        vim.cmd 'write'
        vim.cmd 'edit'
        pcall(vim.treesitter.start, 0)
      end, { bang = true })
    end,
  },
}
