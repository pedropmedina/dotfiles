local keymapper = require('utils.keymapper')
local map_cmd = keymapper.map_cmd

-- Leader key
vim.g.mapleader = ' '
vim.fn.nvim_set_keymap('n', ' ', '', { noremap = true })
vim.fn.nvim_set_keymap('x', ' ', '', { noremap = true })

local mappings = setmetatable({}, { __index = { vim = {}, plugin = {} } })

function mappings:load_vim_define()
  self.vim = {
    -- Better indenting
    ['v|<']           = map_cmd('< gv'):with_noremap():with_silent(),
    ['v|>']           = map_cmd('> gv'):with_noremap():with_silent(),

    -- Save and quit files mapper('n', '<Leader>w', ':w!<CR>')
    ['n|<Leader>w']  =  map_cmd(':w!<CR>'):with_noremap():with_silent(),
    ['n|<Leader>wq']  = map_cmd(':wq<CR>'):with_noremap():with_silent(),
    ['n|<Leader>q']   = map_cmd(':confirm wqa<CR>'):with_noremap():with_silent(),

    -- Find and Replace selected words in normal/visual mode with * ['n|<Leader>fr']  = map_cmd(':%s///g<Left><Left>'):with_noremap():with_silent(),
    ['x|<Leader>fr']  = map_cmd(':%s///g<Left><Left>'):with_noremap():with_silent(),

    -- Multiple cursors alternative. Under a word or selection replace word with 's*' and repeat instance with '.'
    ['n|s*' ]         = map_cmd(":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn"),
    ['x|s*']          = map_cmd('"sy:let @/=@s<CR>cgn'),

    -- Current window split horizontally, vertically, equal size
    ['n|<Leader>_']   = map_cmd('<C-w>s'):with_noremap():with_silent(),
    ['n|<Leader>|']   = map_cmd('<C-w>v'):with_noremap():with_silent(),
    ['n|<Leader>=']   = map_cmd('<C-w>='):with_noremap():with_silent(),


    -- Normal mode window navigation
    ['n|<C-h>']       = map_cmd('<C-w>h'):with_noremap():with_silent(),
    ['n|<C-j>']       = map_cmd('<C-w>j'):with_noremap():with_silent(),
    ['n|<C-k>']       = map_cmd('<C-w>k'):with_noremap():with_silent(),
    ['n|<C-l>']       = map_cmd('<C-w>l'):with_noremap():with_silent(),

    -- Insert mode navigation
    ['i|<C-h>']       = map_cmd('<Esc><C-w>h'):with_noremap():with_silent(),
    ['i|<C-j>']       = map_cmd('<Esc><C-w>j'):with_noremap():with_silent(),
    ['i|<C-k>']       = map_cmd('<Esc><C-w>k'):with_noremap():with_silent(),
    ['i|<C-l>']       = map_cmd('<Esc><C-w>l'):with_noremap():with_silent(),

    -- Terminal window navigation
    ['t|<Esc>']       = map_cmd('<C-\\><C-N>'):with_noremap():with_silent(),
    ['t|<C-h>']       = map_cmd('<C-\\><C-N><C-w>h'):with_noremap():with_silent(),
    ['t|<C-j>']       = map_cmd('<C-\\><C-N><C-w>j'):with_noremap():with_silent(),
    ['t|<C-k>']       = map_cmd('<C-\\><C-N><C-w>k'):with_noremap():with_silent(),
    ['t|<C-l>']       = map_cmd('<C-\\><C-N><C-w>l'):with_noremap():with_silent(),

    -- Buffers navigation
    ['n|<Leader>bl']  = map_cmd(':bnext<CR>'):with_noremap():with_silent(),
    ['n|<Leader>bh']  = map_cmd(':bprevious<CR>'):with_noremap():with_silent(),
    ['n|<Leader>bq']  = map_cmd(':bdelete<CR>'):with_noremap():with_silent(),

    -- Tabs navigation
    ['n|<TAB>']       = map_cmd(':tabnext<CR>'):with_noremap():with_silent(),
    ['n|<S-TAB>']     = map_cmd(':tabprevious<CR>'):with_noremap():with_silent(),
    ['n|<Leader>tl']  = map_cmd(':tabnext<CR>'):with_noremap():with_silent(),
    ['n|<Leader>th']  = map_cmd(':tabprevious<CR>'):with_noremap():with_silent(),
    ['n|<Leader>tq']  = map_cmd(':tabclose<CR>'):with_noremap():with_silent(),

    -- Work around for using alt key to resize widows on mac
    ['n|˚']           = map_cmd(':resize -2<CR>'):with_noremap():with_silent(),
    ['n|∆']           = map_cmd(':resize +2<CR>'):with_noremap():with_silent(),
    ['n|˙']           = map_cmd(':vertical resize -2<CR>'):with_noremap():with_silent(),
    ['n|¬']           = map_cmd(':vertical resize +2<CR>'):with_noremap():with_silent(),

    -- Opening new terminal emulators
    ['n|<Leader>tt']  = map_cmd(':tabnew +terminal<CR>'):with_noremap():with_silent(),
    ['n|<Leader>ts']  = map_cmd(':new +terminal<CR>'):with_noremap():with_silent(),
    ['n|<Leader>tv']  = map_cmd(':vnew +terminal<CR>'):with_noremap():with_silent()
  }
end

function mappings:load_plugin_define()
  self.plugin = {
    -- Lua tree
    ['n|<Leader>e']   = map_cmd(':NvimTreeToggle<CR>'):with_noremap():with_silent(),

    -- Telescope
    ['n|<Leader>ff']  = map_cmd('<cmd>lua require("plugins.configs.telescope.finders").find_files()<CR>'):with_noremap():with_silent(),
    ['n|<Leader>fd']  = map_cmd('<cmd>lua require("plugins.configs.telescope.finders").find_dotfiles()<CR>'):with_noremap():with_silent(),
    ['n|<Leader>fg']  = map_cmd('<cmd>lua require("plugins.configs.telescope.finders").live_grep()<CR>'):with_noremap():with_silent(),
    ['n|<Leader>fb']  = map_cmd('<cmd>lua require("plugins.configs.telescope.finders").buffers()<CR>'):with_noremap():with_silent(),
    ['n|<Leader>fl']  = map_cmd('<cmd>lua require("plugins.configs.telescope.finders").current_buffer_fuzzy_find()<CR>'):with_noremap():with_silent(),

    -- Completion nvim
    ['i|<C-p>']       = map_cmd('<Plug>(completion_trigger)'):with_silent(),
    ['i|<C-n>']       = map_cmd('<Plug>(completion_trigger)'):with_silent(),
    ['i|<cr>']        = map_cmd([[pumvisible() ? complete_info()["selected"] != "-1" ? "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"]]):with_expr(),
    ['i|<Tab>']       = map_cmd([[pumvisible() ? "\<C-n>" : "\<Tab>"]]):with_noremap():with_expr(),
    ['i|<S-Tab>']     = map_cmd([[pumvisible() ? "\<C-p>" : "\<S-Tab>"]]):with_noremap():with_expr(),
    ['i|<c-j>']       = map_cmd('<Plug>(completion_next_source)'),
    ['i|<c-k>']       = map_cmd('<Plug>(completion_prev_source)')

    -- Moved these mappings under the on_attach callback under the lsp_config.lua file
    -- -- Lsp
    -- ['n|K']           = map_cmd('<cmd>lua vim.lsp.buf.hover()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gd']  = map_cmd('<cmd>lua vim.lsp.buf.definition()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gh']  = map_cmd('<cmd>lua vim.lsp.buf.hover()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gi']  = map_cmd('<cmd>lua vim.lsp.buf.implementation()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gk']  = map_cmd('<cmd>lua vim.lsp.buf.signature_help()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gt']  = map_cmd('<cmd>lua vim.lsp.buf.type_definition()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gr']  = map_cmd('<cmd>lua vim.lsp.buf.references()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>g0']  = map_cmd('<cmd>lua vim.lsp.buf.document_symbol()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gw']  = map_cmd('<cmd>lua vim.lsp.buf.workspace_symbol()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>gf']  = map_cmd('<cmd>lua vim.lsp.buf.formatting()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>grn'] = map_cmd('<cmd>lua vim.lsp.buf.rename()<CR>'):with_noremap():with_silent(),
    -- ['n|<leader>ca']  = map_cmd('<cmd>lua vim.lsp.buf.code_action()<CR>'):with_noremap():with_silent(),
    -- ['x|ca']          = map_cmd("<cmd>'<'>lua vim.lsp.buf.range_code_action()<CR>"):with_noremap():with_silent(),
    --
    -- -- Diagnostic
    -- ['n|<Leader>dj']  = map_cmd('<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>dk']  = map_cmd('<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>dl']  = map_cmd('<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'):with_noremap():with_silent(),
    -- ['n|<Leader>ds']  = map_cmd('<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>'):with_noremap():with_silent(),

    -- -- COC - completion
    -- ['i|<Tab>']       = map_cmd([[pumvisible() ? "\<C-n>" : "\<TAB>"]]):with_noremap():with_expr(),
    -- ['i|<S-Tab>']     = map_cmd([[pumvisible() ? "\<C-p>" : "\C-h>"]]):with_noremap():with_expr(),
    -- ['i|<c-space>']   = map_cmd([[coc#refresh()]]):with_silent():with_noremap():with_expr(),
    -- ['i|<cr>']        = map_cmd([[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]]):with_silent():with_noremap():with_expr(),
    --
    -- -- COC - diagnostics
    -- ['n|<Leader>dl']  = map_cmd('<Plug>(coc-diagnostic-info)'):with_silent(),
    -- ['n|<Leader>dj']  = map_cmd('<Plug>(coc-diagnostic-next)'):with_silent(),
    -- ['n|<Leader>dk']  = map_cmd('<Plug>(coc-diagnostic-prev)'):with_silent(),
    -- ['n|<Leader>ds']  = map_cmd(':CocDiagnostics<CR>'):with_noremap():with_silent(),
    --
    -- -- COC - lsp
    -- ['n|<Leader>or']  = map_cmd([[:call CocAction('runCommand', 'editor.action.organizeImport')<CR>]]):with_noremap():with_silent(),
    -- ['n|K']           = map_cmd([[:call CocActionAsync('doHover')<CR>]]):with_noremap():with_silent(),
    -- ['n|<Leader>gh']  = map_cmd([[:call CocActionAsync('doHover')<CR>]]):with_noremap():with_silent(),
    -- ['n|<Leader>gf']  = map_cmd('<Plug>(coc-format)'):with_silent(),
    -- ['n|<leader>ca']  = map_cmd('<Plug>(coc-codeaction)'):with_silent(),
    -- ['x|ca']          = map_cmd('<Plug>(coc-codeaction-selected)'):with_silent(),
    -- ['n|<Leader>gd']  = map_cmd('<Plug>(coc-definition)'):with_silent(),
    -- ['n|<Leader>gD']  = map_cmd('<Plug>(coc-declaration)'):with_silent(),
    -- ['n|<Leader>gi']  = map_cmd('<Plug>(coc-implementation)'):with_silent(),
    -- ['n|<Leader>gt']  = map_cmd('<Plug>(coc-type-definition)'):with_silent(),
    -- ['n|<Leader>gr']  = map_cmd('<Plug>(coc-references)'):with_silent(),
    -- ['n|<Leader>grn'] = map_cmd('<Plug>(coc-rename)'):with_silent(),
  }
end

local function load_mappings()
  mappings:load_plugin_define()
  mappings:load_vim_define()
  keymapper.nvim_load_mapping(mappings.vim)
  keymapper.nvim_load_mapping(mappings.plugin)
end

load_mappings()
