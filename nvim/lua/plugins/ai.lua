-- AI assistant
-- https://github.com/supermaven-inc/supermaven-nvim

return {
  'supermaven-inc/supermaven-nvim',
  event = 'VimEnter',
  config = function()
    require('supermaven-nvim').setup {}
  end,
}
