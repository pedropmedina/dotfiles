-- `Rosé Pine` theme
-- All natural pine, faux fur and a bit of soho vibes for the classy minimalist
-- https://github.com/rose-pine/neovim
--
-- Rosé Pine has three variants: main, moon, and dawn. By default, vim.o.background
-- is followed, using dawn when light and dark_variant when dark.
return {
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup {
      -- auto, main, moon, or dawn
      variant = 'auto',
      -- main, moon, or dawn
      dark_variant = 'main',
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        -- Improve compatibility for previous versions of Neovim
        legacy_highlights = true,
        -- Handle deprecated options automatically
        migrations = true,
      },
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
      highlight_groups = {
        WinSeparator = { fg = 'overlay', bg = 'base' },
        TelescopePromptNormal = { bg = 'overlay' },
        TelescopePromptBorder = { bg = 'overlay' },
        TelescopePromptTitle = { bg = 'foam', fg = 'overlay' },
        TelescopeResultsTitle = { bg = 'surface', fg = 'surface' },
      },
    }

    vim.api.nvim_command 'colorscheme rose-pine'
  end,
}
