-- Highlight, edit, and navigate code
-- https://github.com/nvim-treesitter/nvim-treesitter

return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  event = 'BufRead',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      config = function()
        -- When in diff mode, we want to use the default
        -- vim text objects c & C instead of the treesitter ones.
        local move = require 'nvim-treesitter.textobjects.move' ---@type table<string,fun(...)>
        local configs = require 'nvim-treesitter.configs'
        for name, fn in pairs(move) do
          if name:find 'goto' == 1 then
            move[name] = function(q, ...)
              if vim.wo.diff then
                local config = configs.get_module('textobjects.move')[name] ---@type table<string,string>
                for key, query in pairs(config or {}) do
                  if q == query and key:find '[%]%[][cC]' then
                    vim.cmd('normal! ' .. key)
                    return
                  end
                end
              end
              return fn(q, ...)
            end
          end
        end
      end,
    },
  },
  opts = {
    ensure_installed = {
      'bash',
      'sql',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'vim',
      'vimdoc',
      'javascript',
      'typescript',
      'tsx',
      'jsdoc',
      'json',
      'jsonc',
      'python',
      'go',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      -- If you are experiencing weird indenting issues, add the language to
      -- the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = { enable = true },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
      },
    },
  },
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  config = function(_, opts)
    if type(opts.ensure_installed) == 'table' then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed) ---@diagnostic disable-line:param-type-mismatch
    end

    require('nvim-treesitter.configs').setup(opts)

    -- Reset treesitter highlights
    vim.api.nvim_create_user_command('TSResetHighlight', 'write | edit | TSBufEnable highlight', { bang = true })
  end,
}
