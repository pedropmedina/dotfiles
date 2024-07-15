-- Replacement to null-ls. It's easy to configure.
-- mfussenegger/nvim-lint (https://github.com/mfussenegger/nvim-lint)

return {
  {
    'mfussenegger/nvim-lint',
    -- events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    event = 'BufReadPost',
    config = function()
      local lint = require 'lint'
      -- stylua: ignore start
      lint.linters_by_ft = {
        ['fish'] =            { 'fish' },
        ['typescript'] =      { 'eslint' },
        ['javascript'] =      { 'eslint' },
        ['typescriptreact'] = { 'eslint' },
        ['json'] =            { 'eslint' },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
      }
      -- stylua: ignore end

      -- Create autocommand which carries out the actual linting on the specified events.
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
