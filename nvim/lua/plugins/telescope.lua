-- Fuzzy Finder (files, lsp, etc)
-- https://github.com/nvim-telescope/telescope.nvim

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  -- cmd = 'Telescope',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',
      -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    -- Sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the
    -- telescope picker. Example would be lua vim.lsp.buf.code_action()
    { 'nvim-telescope/telescope-ui-select.nvim' },
    -- Browser extension for telescope.nvim. It supports synchronized creation, deletion, renaming,
    -- and moving of files and folders powered
    {
      'nvim-telescope/telescope-file-browser.nvim',
      build = 'make',
      enabled = vim.fn.executable 'make' == 1,
    },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`

    -- See `:help telescope.actions`
    local actions = require 'telescope.actions'

    -- Add selection to quickfix list and open it
    local send_selected_to_qflist = function(prompt_bufnr, mode, target)
      actions.send_selected_to_qflist(prompt_bufnr, mode, target)
      actions.open_qflist(0)
    end

    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      -- All the info you're looking for is in `:help telescope.setup()`
      defaults = {
        layout_config = { prompt_position = 'top', preview_cutoff = 200 },
        prompt_prefix = '  ',
        selection_caret = '  ',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        winblend = 0,
        borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        layout_strategy = 'horizontal',
        scroll_strategy = 'cycle',
        file_ignore_patterns = { 'node_modules/.*', '.git/.*', 'yarn.lock', '\\.next/.*' },
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == '' then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ['<C-s>'] = actions.select_horizontal,
            ['œ'] = send_selected_to_qflist,
          },
          n = {
            ['q'] = actions.close,
            ['œ'] = send_selected_to_qflist,
          },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'file_browser')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sE', ':Telescope file_browser<CR>', { desc = '[S]earch file browser' })
    vim.keymap.set('n', '<leader>se', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { desc = '[S]earch file browser' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find()
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
