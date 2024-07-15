-- Collection of various small independent plugins/modules
-- https://github.com/echasnovski/mini.nvim
--
-- Since the `mini` collection provides a pretty comprehensive set
-- of plugins to handle lots of functions, I find it better to stick
-- within their framework.
--
-- Here's a list of the `mini` plugins we're using in this file:
-- 1. mini.icons
-- 2. mini.ai
-- 3. mini.pais
-- 4. mini.comments
-- 5. mini.surround

return {
  'echasnovski/mini.nvim',
  version = false,
  event = 'BufRead',
  dependencies = {
    -- Useful when working with embedded languages such as Vue, Svelte, ... files
    -- where there can be several sections, each of which can have a different style for comments.
    -- This plugin is a dependency `mini.comment`.
    -- See h ts-context-commentstring.
    { 'JoosepAlviste/nvim-ts-context-commentstring', opts = { enable_autocmd = false } },
  },
  config = function()
    -- Useful for rendering file ext icons. Currently there's an issue with `Telescope`
    -- and the we need to call `mock_nvim_web_devicons` in order for it to work.
    require('mini.icons').setup {}
    require('mini.icons').mock_nvim_web_devicons()

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Add closing matching pair
    -- https://github.com/echasnovski/mini.pairs
    --
    -- Pairing e.g [], {}, <>, ''...
    require('mini.pairs').setup()

    -- Comment lines with gcc, gc} ...
    -- https://github.com/echasnovski/mini.comment
    -- NOTE: Neovim version 0.10 introduced a built-in comment functionality, however
    -- I couldn't get it to work with *.(jsx|tsx). Keep in an eye for upcoming releases
    -- as we might not need this plugin at all.
    require('mini.comment').setup {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    }
  end,
}
