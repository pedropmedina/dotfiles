-- AI assistant
-- https://github.com/supermaven-inc/supermaven-nvim
--
-- Opencode
-- https://github.com/NickvanDyke/opencode.nvim

return {
  {

    'supermaven-inc/supermaven-nvim',
    event = 'VimEnter',
    config = function()
      require('supermaven-nvim').setup {}
    end,
  },

  {
    'NickvanDyke/opencode.nvim',
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      vim.keymap.set({ 'n', 't' }, '<leader>oo', function()
        require('opencode').toggle()
      end, { desc = '[O]pencode [T]oggle side TUI' })

      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        require('opencode').select()
      end, { desc = '[O]pencode [S]xecute actions…' })

      vim.keymap.set({ 'n', 'x' }, '<leader>or', function()
        return require('opencode').operator '@this '
      end, { expr = true, desc = '[O]pencode add range to prompt' })
      vim.keymap.set('n', '<leader>ol', function()
        return require('opencode').operator '@this ' .. '_'
      end, { expr = true, desc = '[O]pencode add line to prompt' })

      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        require('opencode').ask('@this: ', { submit = true })
      end, { desc = '[O]pencode [C]ontext ask under operator range or visual selection if any, else cursor position' })
      vim.keymap.set({ 'n', 'x' }, '<leader>ob', function()
        require('opencode').ask('@buffer: ', { submit = true })
      end, { desc = '[O]pencode [C]ontext ask under current buffer' })
      vim.keymap.set({ 'n', 'x' }, '<leader>od', function()
        require('opencode').ask('@diagnostics: ', { submit = true })
      end, { desc = '[O]pencode [C]ontext ask under current buffer diagnostics' })
      vim.keymap.set({ 'n', 'x' }, '<leader>oq', function()
        require('opencode').ask('@quickfix: ', { submit = true })
      end, { desc = '[O]pencode [C]ontext ask under quickfix list' })
    end,
  },
}
