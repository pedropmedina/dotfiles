local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end

require'nvim_lsp'.bashls.setup{ on_attach = on_attach_vim }

require'nvim_lsp'.cssls.setup{ on_attach = on_attach_vim, settings = { css = { validate = false } }}

require'nvim_lsp'.diagnosticls.setup{ on_attach = on_attach_vim }

require'nvim_lsp'.html.setup{ 
  on_attach = on_attach_vim, 
  filetypes = { "html", "tsx", "jsx", "vue", "hbs" } 
}

require'nvim_lsp'.tsserver.setup{ on_attach = on_attach_vim }

require'nvim_lsp'.jsonls.setup{ on_attach = on_attach_vim }

require'nvim_lsp'.vimls.setup{ on_attach = on_attach_vim }

-- Tweak vetur config a bit to improve performance 
require'nvim_lsp'.vuels.setup{ 
  on_attach = on_attach_vim, 
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {}
      },
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
