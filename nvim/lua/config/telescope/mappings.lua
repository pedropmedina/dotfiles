local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<Leader>ff", [[<cmd>lua require("config/telescope/finders").find_files()<CR>]], opts)
map("n", "<Leader>fg", [[<cmd>lua require("config/telescope/finders").live_grep()<CR>]], opts)
map("n", "<Leader>fd", [[<cmd>lua require("config/telescope/finders").find_dotfiles()<CR>]], opts)
map("n", "<Leader>fs", [[<cmd>lua require("config/telescope/finders").grep_string()<CR>]], opts)
map("n", "<Leader>fb", [[<cmd>lua require("config/telescope/finders").buffers()<CR>]], opts)
map("n", "<Leader>fl", [[<cmd>lua require("config/telescope/finders").current_buffer_fuzzy_find()<CR>]], opts)
