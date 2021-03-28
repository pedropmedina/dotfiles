local keymapper = require("utils.keymapper")
local map_cmd = keymapper.map_cmd

-- Leader key
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
vim.api.nvim_set_keymap("x", " ", "", { noremap = true })

local mappings = setmetatable({}, { __index = { vim = {}, plugin = {} } })

function mappings:load_vim_define()
    self.vim = {
        -- Better indenting
        ["v|<"] = map_cmd("< gv"):with_noremap():with_silent(),
        ["v|>"] = map_cmd("> gv"):with_noremap():with_silent(),

        -- Save and quit files mapper('n', '<Leader>w', ':w!<CR>')
        ["n|<Leader>w"] = map_cmd(":w!<CR>"):with_noremap():with_silent(),
        ["n|<Leader>wq"] = map_cmd(":wq<CR>"):with_noremap():with_silent(),
        ["n|<Leader>q"] = map_cmd(":confirm wqa<CR>"):with_noremap():with_silent(),

        -- Find and Replace selected words in normal/visual mode with * ['n|<Leader>fr']  = map_cmd(':%s///g<Left><Left>'):with_noremap():with_silent(),
        ["x|<Leader>fr"] = map_cmd(":%s///g<Left><Left>"):with_noremap():with_silent(),

        -- Multiple cursors alternative. Under a word or selection replace word with 's*' and repeat instance with '.'
        ["n|s*"] = map_cmd(":let @/='\\<'.expand('<cword>').'\\>'<CR>cgn"),
        ["x|s*"] = map_cmd("\"sy:let @/=@s<CR>cgn"),

        -- Current window split horizontally, vertically, equal size
        ["n|<Leader>_"] = map_cmd("<C-w>s"):with_noremap():with_silent(),
        ["n|<Leader>|"] = map_cmd("<C-w>v"):with_noremap():with_silent(),
        ["n|<Leader>="] = map_cmd("<C-w>="):with_noremap():with_silent(),

        -- Normal mode window navigation
        ["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap():with_silent(),
        ["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap():with_silent(),
        ["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap():with_silent(),
        ["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap():with_silent(),

        -- Insert mode navigation
        ["i|<C-h>"] = map_cmd("<Esc><C-w>h"):with_noremap():with_silent(),
        ["i|<C-j>"] = map_cmd("<Esc><C-w>j"):with_noremap():with_silent(),
        ["i|<C-k>"] = map_cmd("<Esc><C-w>k"):with_noremap():with_silent(),
        ["i|<C-l>"] = map_cmd("<Esc><C-w>l"):with_noremap():with_silent(),

        -- Terminal window navigation
        ["t|<Esc>"] = map_cmd("<C-\\><C-N>"):with_noremap():with_silent(),
        ["t|<C-h>"] = map_cmd("<C-\\><C-N><C-w>h"):with_noremap():with_silent(),
        ["t|<C-j>"] = map_cmd("<C-\\><C-N><C-w>j"):with_noremap():with_silent(),
        ["t|<C-k>"] = map_cmd("<C-\\><C-N><C-w>k"):with_noremap():with_silent(),
        ["t|<C-l>"] = map_cmd("<C-\\><C-N><C-w>l"):with_noremap():with_silent(),

        -- Buffers navigation
        ["n|<Leader>bl"] = map_cmd(":bnext<CR>"):with_noremap():with_silent(),
        ["n|<Leader>bh"] = map_cmd(":bprevious<CR>"):with_noremap():with_silent(),
        ["n|<Leader>bq"] = map_cmd(":bdelete<CR>"):with_noremap():with_silent(),

        -- Tabs navigation
        ["n|<TAB>"] = map_cmd(":tabnext<CR>"):with_noremap():with_silent(),
        ["n|<S-TAB>"] = map_cmd(":tabprevious<CR>"):with_noremap():with_silent(),
        ["n|<Leader>tl"] = map_cmd(":tabnext<CR>"):with_noremap():with_silent(),
        ["n|<Leader>th"] = map_cmd(":tabprevious<CR>"):with_noremap():with_silent(),
        ["n|<Leader>tq"] = map_cmd(":tabclose<CR>"):with_noremap():with_silent(),

        -- Work around for using alt key to resize widows on mac
        ["n|˚"] = map_cmd(":resize -2<CR>"):with_noremap():with_silent(),
        ["n|∆"] = map_cmd(":resize +2<CR>"):with_noremap():with_silent(),
        ["n|˙"] = map_cmd(":vertical resize -2<CR>"):with_noremap():with_silent(),
        ["n|¬"] = map_cmd(":vertical resize +2<CR>"):with_noremap():with_silent(),

        -- Opening new terminal emulators
        ["n|<Leader>tt"] = map_cmd(":tabnew +terminal<CR>"):with_noremap():with_silent(),
        ["n|<Leader>ts"] = map_cmd(":new +terminal<CR>"):with_noremap():with_silent(),
        ["n|<Leader>tv"] = map_cmd(":vnew +terminal<CR>"):with_noremap():with_silent()
    }
end

function mappings:load_plugin_define()
    self.plugin = {
        -- Lua tree
        ["n|<Leader>e"] = map_cmd(":NvimTreeToggle<CR>"):with_noremap():with_silent(),

        -- Telescope
        ["n|<Leader>ff"] = map_cmd([[<cmd>lua require("config/telescope/finders").find_files()<CR>]]):with_noremap()
            :with_silent(),
        ["n|<Leader>fd"] = map_cmd([[<cmd>lua require("config/telescope/finders").find_dotfiles()<CR>]]):with_noremap()
            :with_silent(),
        ["n|<Leader>fg"] = map_cmd([[<cmd>lua require("config/telescope/finders").live_grep()<CR>]]):with_noremap()
            :with_silent(),
        ["n|<Leader>fs"] = map_cmd([[<cmd>lua require("config/telescope/finders").grep_string()<CR>]]):with_noremap()
            :with_silent(),
        ["n|<Leader>fb"] = map_cmd([[<cmd>lua require("config/telescope/finders").buffers()<CR>]]):with_noremap()
            :with_silent(),
        ["n|<Leader>fl"] = map_cmd(
            [[<cmd>lua require(\"plugins.config.telescope.finders\").current_buffer_fuzzy_find()<CR>]]
        ):with_noremap():with_silent(),

        -- Completion
        ["i|<C-Space>"] = map_cmd([[compe#complete()]]):with_noremap():with_silent():with_expr(),
        ["i|<CR>"] = map_cmd([[compe#confirm({'keys': "\<Plug>delimitMateCR", 'mode': ''})]]):with_noremap()
            :with_silent():with_expr(),
        ["i|<C-e>"] = map_cmd([[compe#close('<C-e>')]]):with_noremap():with_silent():with_expr(),
        ["i|<C-f>"] = map_cmd([[compe#scroll({ 'delta': +4 })]]):with_noremap():with_silent():with_expr(),
        ["i|<C-d>"] = map_cmd([[compe#scroll({ 'delta': -4 })]]):with_noremap():with_silent():with_expr(),
        ["i|<Tab>"] = map_cmd([[v:lua.tab_complete()]]):with_noremap():with_silent():with_expr(),
        ["s|<Tab>"] = map_cmd([[v:lua.tab_complete()]]):with_noremap():with_silent():with_expr(),
        ["i|<S-Tab>"] = map_cmd([[v:lua.s_tab_complete()]]):with_noremap():with_silent():with_expr(),
        ["s|<S-Tab>"] = map_cmd([[v:lua.s_tab_complete()]]):with_noremap():with_silent():with_expr()
    }
end

local function load_mappings()
    mappings:load_plugin_define()
    mappings:load_vim_define()
    keymapper.nvim_load_mapping(mappings.vim)
    keymapper.nvim_load_mapping(mappings.plugin)
end

load_mappings()
