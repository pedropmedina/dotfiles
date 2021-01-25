local lspconfig = require('lspconfig')
local completion = require('completion')

local on_attach_vim = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  completion.on_attach(client)

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Lsp
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<Leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Leader>gk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', '<Leader>gw', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  buf_set_keymap('n', '<Leader>grn','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('x', '<Leader>ca', "<cmd>'<'>lua vim.lsp.buf.range_code_action()<CR>", opts)

  -- Diagnostic
  buf_set_keymap('n', '<Leader>dl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>dk', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<Leader>dj', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>ds', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<Leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<Leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
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

lspconfig.sumneko_lua.setup{
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

--Enable (broadcasting) snippet capability for completion - No sure if this will be needed in the future
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup{
  cmd = { 'html-languageserver', '--stdio' },
  capabilities = capabilities,
  on_attach = on_attach_vim,
  filetypes = { 'html', 'tsx', 'jsx', 'vue', 'hbs', 'handlebars',  'html.hbs', 'html.handlebars', 'liquid' }
}

lspconfig.cssls.setup{
  cmd = { 'css-languageserver', '--stdio' },
  capabilities = capabilities,
  on_attach = on_attach_vim,
  settings = { css = { validate = false } }
}

lspconfig.bashls.setup{
  cmd = { 'bash-language-server', 'start' },
  on_attach = on_attach_vim
}

lspconfig.vimls.setup{
  cmd = { 'vim-language-server', '--stdio' },
  on_attach = on_attach_vim
}

lspconfig.jsonls.setup{
  cmd = { "vscode-json-languageserver", "--stdio" },
  on_attach = on_attach_vim
}

lspconfig.tsserver.setup{
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
lspconfig.vuels.setup{
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
