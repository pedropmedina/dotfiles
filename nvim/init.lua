require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Uses treesitter to autoclose and autorename html tag
  -- Before        Input         After
  -- ------------------------------------------
  -- <div           >              <div></div>
  -- <div></div>    ciwspan<esc>   <span></span>
  -- ------------------------------------------
  { 'windwp/nvim-ts-autotag', event = 'BufRead', opts = {} },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'BufRead', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  --  Keep plugins' config that require a bit more work in `lua/pkgs/*.lua`.
  --  For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'plugins' },
}, {
  checker = {
    enabled = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
