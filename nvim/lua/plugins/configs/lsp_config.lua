-- callback fn
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
end

-- get current system name
local system_name
if vim.fn.has('mac') == 1 then
  system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
  system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsupported system for sumneko.')
end

-- NOTE: Sumneko Lua config is a bit more involved than the rest as we have to set the command.
-- Set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'

require'lspconfig'.sumneko_lua.setup{
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach_vim,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim', 'use' },
      },
    }
  }
}

require'lspconfig'.bashls.setup{
  cmd = { 'bash-language-server', 'start' },
  on_attach = on_attach_vim
}

require'lspconfig'.vimls.setup{
  cmd = { 'vim-language-server', '--stdio' },
  on_attach = on_attach_vim
}

require'lspconfig'.cssls.setup{
  cmd = { 'css-languageserver', '--stdio' },
  on_attach = on_attach_vim,
  settings = { css = { validate = true } }
}

require'lspconfig'.html.setup{
  cmd = { 'html-languageserver', '--stdio' },
  on_attach = on_attach_vim,
  filetypes = { 'html', 'tsx', 'jsx', 'vue', 'hbs', 'handlebars',  'html.hbs', 'html.handlebars', 'liquid' }
}

require'lspconfig'.jsonls.setup{
  cmd = { 'json-language-server', '--stdio' },
  on_attach = on_attach_vim
}

require'lspconfig'.tsserver.setup{
  cmd = { 'typescript-language-server', '--stdio' },
  on_attach = on_attach_vim,
  filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx'
      },
}

-- Tweak vetur config a bit to improve performance
require'lspconfig'.vuels.setup{
  cmd = { 'vls' },
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
          tagCasing = 'kebab',
          useScaffoldSnippets = false,
          scaffoldSnippetSource = ''
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
