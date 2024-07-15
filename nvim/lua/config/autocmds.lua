-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('ag__highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  desc = 'Resize splits',
  group = vim.api.nvim_create_augroup('ag__resize_splits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Go to the position where the cursor was last set for the current buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Go to the position where the cursor was last set for the current buffer',
  group = vim.api.nvim_create_augroup('ag__buff_cursor_last_position', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].buff_cursor_last_position then
      return
    end
    vim.b[buf].buff_cursor_last_position = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Allow closing some file types with `q`',
  group = vim.api.nvim_create_augroup('ag__close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Wrap and check for spell in text filetypes',
  group = vim.api.nvim_create_augroup('ag__wrap_spell', { clear = true }),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Auto create dir when saving a file, in case some intermediate directory does not exist',
  group = vim.api.nvim_create_augroup('ag__auto_create_dir', { clear = true }),
  callback = function(event)
    if event.match:match '^%w%w+://' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Remove number column from terminal emulator window
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  desc = 'Remove number column from terminal emulator window',
  group = vim.api.nvim_create_augroup('ag__remove_term_number_col', { clear = true }),
  callback = function()
    vim.cmd 'startinsert'
    vim.cmd 'setlocal nonumber norelativenumber'
  end,
})

-- Force formatoptions. No sure why setting them in the options file isn't enough?
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile' }, {
  desc = 'Force formatoptions',
  group = vim.api.nvim_create_augroup('ag__force_formatoptions', { clear = true }),
  callback = function()
    vim.cmd 'setlocal formatoptions-=cro'
  end,
})

-- Use this command to register some file extensions such to get LSP working properly.
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
  desc = 'Register some filetypes',
  group = vim.api.nvim_create_augroup('ag__file_types', { clear = true }),
  callback = function()
    vim.filetype.add {
      extension = {
        templ = 'templ',
      },
    }
  end,
})
