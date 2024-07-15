-- Autoformat
-- https://github.com/stevearc/conform.nvim

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
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
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
    },
    -- stylua: ignore end
  },
}
