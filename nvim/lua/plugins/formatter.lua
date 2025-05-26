-- Autoformat
-- https://github.com/stevearc/conform.nvim

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = '[D]isable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = '[R]e-enable autoformat-on-save',
})

return {
  'stevearc/conform.nvim',
  event = 'BufRead',
  keys = {
    {
      '<leader>cF',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = { 'n', 'v' },
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disabled_filetypes = { c = true, cpp = true, sql = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disabled_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    -- stylua: ignore start
    formatters_by_ft = {
      ['lua']             = { 'stylua' },
      ['fish']            = { 'fish_indent' },
      ['sh']              = { 'shfmt' },
      ['html']            = { 'prettier' },
      ['css']             = { 'prettier' },
      ['scss']            = { 'prettier' },
      ['less']            = { 'prettier' },
      ['json']            = { 'prettier' },
      ['jsonc']           = { 'prettier' },
      ['yaml']            = { 'prettier' },
      ['markdown']        = { 'prettier' },
      ['javascript']      = { 'prettier' },
      ['javascriptreact'] = { 'prettier' },
      ['typescript']      = { 'prettier' },
      ['typescriptreact'] = { 'prettier' },
      ['astro']           = { 'prettier' },
      ['vue']             = { 'prettier' },
      ['graphql']         = { 'prettier' },
      ['handlebars']      = { 'prettier' },
      ['markdown.mdx']    = { 'prettier' },
      ['python']          = { 'ruff_format' },
      ['sql']             = { 'sqlfluff' },
    },
    -- stylua: ignore end
  },
}
