-- No need to have a key associated to confirm completion. We use <CR> instead
vim.g.completion_confirm_key = ""

-- Matching strategies
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

-- Case insensitive matching
vim.g.completion_matching_ignore_case = 1

-- Show completion popup on delete
vim.g.completion_trigger_on_delete = 1

-- Don't open the completion popup on keywords less than 1
vim.g.completion_trigger_keyword_length = 1

-- Some extra trigger characters
vim.g.completion_trigger_character = { '.', '::' }

--Timer controls the rate of completion.
vim.g.completion_timer_cycle = 80

-- Do not open detail floating window while navigating completion items
vim.g.completion_enable_auto_hover = 0

-- Use completion-nvim in every buffer
vim.cmd([[ autocmd BufEnter * lua require'completion'.on_attach() ]])
