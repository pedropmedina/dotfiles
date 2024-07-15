-- An interactive and powerful Git interface for Neovim, inspired by Magit
-- https://github.com/NeogitOrg/neogit

return {
  'NeogitOrg/neogit',
  dependencies = { 'sindrets/diffview.nvim' },
  opts = {},
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', 'n', desc = '[N]eogit [O]pen' },
  },
}
