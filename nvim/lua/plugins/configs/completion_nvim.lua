-- No need to have a key associated to confirm completion. We use <CR> instead
vim.g.completion_confirm_key = ""

-- Matching strategies
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }

-- Enable snippets.nvim
vim.g.completion_enable_snippet = 'vim-vsnip'

-- Case insensitive matching
vim.g.completion_matching_ignore_case = 1

-- Show completion popup on delete
vim.g.completion_trigger_on_delete = 0

-- Don't open the completion popup on keywords less than 1
vim.g.completion_trigger_keyword_length = 2

-- Some extra trigger characters
-- vim.g.completion_trigger_character = { '.', '::' }

--Timer controls the rate of completion.
vim.g.completion_timer_cycle = 200

-- Do not open detail floating window while navigating completion items
vim.g.completion_enable_auto_hover = 0

-- Setup chain completion by separating completion sources into groups
vim.g.completion_chain_complete_list = {
  default = {
    { complete_items = { 'lsp', 'snippet' } },
    { complete_items = { 'buffers' } },
  },
  comment = {},
}

-- Let completion-nvim move across chain completion sources as we run out of matching items
vim.g.completion_auto_change_source = 1

-- Use completion-nvim in every buffer
-- vim.cmd([[ autocmd BufEnter,BufReadPre,BufNewFile * lua require'completion'.on_attach() ]])
vim.cmd([[ autocmd BufEnter * lua require'completion'.on_attach() ]])
