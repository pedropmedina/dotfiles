-- Autocompletion
-- https://github.com/hrsh7th/nvim-cmp

-- local M = {}
--
-- M.icons = setmetatable({
--   Array = ' ',
--   Boolean = '󰨙 ',
--   Class = ' ',
--   Codeium = '󰘦 ',
--   Color = ' ',
--   Control = ' ',
--   Collapsed = ' ',
--   Constant = '󰏿 ',
--   Constructor = ' ',
--   Copilot = ' ',
--   Enum = ' ',
--   EnumMember = ' ',
--   Event = ' ',
--   Field = ' ',
--   File = ' ',
--   Folder = ' ',
--   Function = '󰊕 ',
--   Interface = ' ',
--   Key = ' ',
--   Keyword = ' ',
--   Method = '󰊕 ',
--   Module = ' ',
--   Namespace = '󰦮 ',
--   Null = ' ',
--   Number = '󰎠 ',
--   Object = ' ',
--   Operator = ' ',
--   Package = ' ',
--   Property = ' ',
--   Reference = ' ',
--   Snippet = ' ',
--   String = ' ',
--   Struct = '󰆼 ',
--   TabNine = '󰏚 ',
--   Text = ' ',
--   TypeParameter = ' ',
--   Unit = ' ',
--   Value = ' ',
--   Variable = '󰀫 ',
-- }, {})

local sort_source = function(a, b)
  local order = { supermaven = 7, lsp = 6, snippets = 5, git = 4, path = 3, buffer = 2, lazydev = 1 }
  local a_order_id = order[a.source_id]
  local b_order_id = order[b.source_id]
  if a_order_id ~= b_order_id then
    return a_order_id > b_order_id
  end
end

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = {
      implementation = 'lua',
      sorts = {
        sort_source,
        'score',
        'sort_text',
      },
    },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
