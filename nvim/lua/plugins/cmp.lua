-- Autocompletion
-- https://github.com/hrsh7th/nvim-cmp

local M = {}

M.icons = setmetatable({
  Array = ' ',
  Boolean = '󰨙 ',
  Class = ' ',
  Codeium = '󰘦 ',
  Color = ' ',
  Control = ' ',
  Collapsed = ' ',
  Constant = '󰏿 ',
  Constructor = ' ',
  Copilot = ' ',
  Enum = ' ',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = ' ',
  Folder = ' ',
  Function = '󰊕 ',
  Interface = ' ',
  Key = ' ',
  Keyword = ' ',
  Method = '󰊕 ',
  Module = ' ',
  Namespace = '󰦮 ',
  Null = ' ',
  Number = '󰎠 ',
  Object = ' ',
  Operator = ' ',
  Package = ' ',
  Property = ' ',
  Reference = ' ',
  Snippet = ' ',
  String = ' ',
  Struct = '󰆼 ',
  TabNine = '󰏚 ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = ' ',
  Value = ' ',
  Variable = '󰀫 ',
}, {})

---@param entry cmp.Entry
---@param vim_item vim.CompletedItem
---@return vim.CompletedItem
---@diagnostic disable-next-line: unused-local
M.set_format = function(entry, vim_item)
  if M.icons[vim_item.kind] then
    vim_item.kind = M.icons[vim_item.kind] .. vim_item.kind
  end
  return vim_item
end

return {
  'hrsh7th/nvim-cmp',
  version = false,
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
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
        --  See the README about individual language/framework/plugin snippets:
        --  https://github.com/rafamadriz/friendly-snippets
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {
        history = true,
        delete_check_events = 'TextChanged',
      },
      keys = {
        {
          '<tab>',
          function()
            require('luasnip').jump(1)
          end,
          mode = 's',
        },
        {
          '<s-tab>',
          function()
            require('luasnip').jump(-1)
          end,
          mode = { 'i', 's' },
        },
      },
    },
    -- Integrates L3MON4D3/LuaSnip with nvim-cmp. It servers as `L3MON4D3/LuaSnip` cmp source
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    -- nvim-cmp does not ship with all sources by default. They are split
    -- into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    -- Set highlight color for nvim-cmp experimental ghost_text
    vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        -- Select the [p]revious item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        -- This will auto-import if your LSP supports it.
        -- This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },

        -- If you prefer more traditional completion keymaps,
        -- you can uncomment the following lines
        -- ['<CR>'] = cmp.mapping.confirm { select = true },
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- Manually trigger a completion from nvim-cmp.
        -- Generally you don't need this, because nvim-cmp will display
        -- completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        -- So if you have a snippet that's like:
        -- function $name($args)
        --   $body
        -- end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
      formatting = {
        expandable_indicator = true,
        fields = { 'menu', 'abbr', 'kind' },
        format = M.set_format,
      },
      experimental = {
        ghost_text = {
          hl_group = 'CmpGhostText',
        },
      },
    }
  end,
}
