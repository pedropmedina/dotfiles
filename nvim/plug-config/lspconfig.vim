" Required languages
:lua << END
  local nvim_lsp = require('nvim_lsp')

  local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'diagnostic'.on_attach()
    require'completion'.on_attach()
  end

  -- modify the setting for lsp here
  local settings = {}
  settings['cssls'] = {
    css  =  { validate = false },
    less =  { validate = false },
    scss =  { validate = false }
  }

  -- activate servers
  local servers = {'bashls', 'cssls', 'diagnosticls', 'html', 'tsserver', 'jsonls', 'vimls', 'vuels'}

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      settings = ( settings[lsp] ~= nil and settings[lsp] or {} )
    }
  end
END

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
