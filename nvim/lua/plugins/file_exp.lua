-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
-- https://github.com/stevearc/oil.nvim

return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    columns = {
      'icon',
      -- 'permissions',
      -- 'size',
      -- 'mtime',
    },
    view_options = {
      show_hidden = true,
      natural_order = true,
    },
    win_options = {
      wrap = true,
      winblend = 0,
    },
    keymaps = {
      ['q'] = 'actions.close',
      ['h'] = 'actions.parent',
      ['l'] = 'actions.select',
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
      ['<C-x>'] = { 'actions.select', opts = { horizontal = true } },
    },
  },
  keys = {
    { '<leader>e', '<cmd>OilToggle<cr>', 'n', desc = 'Toggle(Oil) file explorer' },
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.api.nvim_create_user_command('OilToggle', function()
      local oil = require 'oil'
      if vim.bo.filetype == 'oil' then
        oil.close()
      else
        oil.open()
      end
    end, {})
  end,
}
