local on_attach_vim = function(client)
  require'completion'.on_attach(client)
end

require'lspconfig'.bashls.setup{ on_attach = on_attach_vim }

require'lspconfig'.vimls.setup{ on_attach = on_attach_vim }

require'lspconfig'.cssls.setup{ on_attach = on_attach_vim, settings = { css = { validate = false } }}

require'lspconfig'.html.setup{
  on_attach = on_attach_vim,
  filetypes = { "html", "tsx", "jsx", "vue", "hbs", "handlebars", "html.handlebars", "liquid" }
}

require'lspconfig'.jsonls.setup{ on_attach = on_attach_vim }

require'lspconfig'.tsserver.setup{
  on_attach = on_attach_vim,
  filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
      },
}

require'lspconfig'.sumneko_lua.setup{
  on_attach = on_attach_vim,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim", "use" },
      },
    }
  }
}

-- Tweak vetur config a bit to improve performance
require'lspconfig'.vuels.setup{
  on_attach = on_attach_vim,
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {} },
      javascript = {
        format = {}
      },
      stylusSupremacy = {},
      typescript = {
        format = {}
      },
      vetur = {
        completion = {
          autoImport = false,
          tagCasing = "kebab",
          useScaffoldSnippets = false,
          scaffoldSnippetSource = ""
        },
        useWorkspaceDependencies = false,
        validation = {
          script = true,
          style = false,
          template = false,
          templateProps = false
        }
      }
    }
  }
}

-- Experimentation
-- vim.api.nvim_command[[autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil,1000)]]
-- vim.cmd([[ autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil,1000) ]])
-- vim.cmd([[ autocmd BufWritePre *.vim lua vim.lsp.buf.formatting_sync(nil,1000) ]])
-- vim.cmd([[ autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil,1000) ]])

  -- ['<tab>']    = { scope = 'buf', mode = 'i', mapping = [[pumvisible() ? "\<C-n>" : "\<Tab>"]], expr = true };
  -- ['<s-tab>']  = { scope = 'buf', mode = 'i', mapping = [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], expr = true };
  -- ['<c-j>']    = { scope = 'buf', mode = {'i', 's'}, mapping = [[vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>']], expr = true };

