--[[
=============================================
===================== UI ====================
=============================================

Let's keep everything cosmetic related here .

Plugins:
  1. nvim-lualine/lualine.nvim 
  2. nvim-tree/nvim-web-devicons
  3. MunifTanjim/nui.nvim 
  4. rcarriga/nvim-notify
  5. stevearc/dressing.nvim

--]]

local Util = require("util")

return {
  ----------------------------------------------------------
  -- nvim-lualine/lualine.nvim
  -- https://github.com/nvim-lualine/lualine.nvim
  --
  -- There are many plugins out there to customize the
  -- statusline, but this is the more flexible in my opinion.
  ----------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    dependencies = { "catppuccin/nvim" },
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("config").icons

      local colors = require("catppuccin.palettes").get_palette("mocha") or {}

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          disabled_filetypes = { "starter" },
          theme = {
            normal = { c = { fg = colors.surface2, bg = colors.mantle } },
            inactive = { c = { fg = colors.surface2, bg = colors.mantle } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        tabline = {},
        extensions = { "quickfix", "lazy" },
      }

      -- Inserts a component in lualine_a at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_z at right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left({
        -- mode component
        function()
          return "▊"
        end,
        color = function()
          local mode_color = {
            n = colors.blue,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.pink,
            no = colors.red,
            s = colors.peach,
            S = colors.peach,
            [""] = colors.peach,
            ic = colors.yellow,
            R = colors.lavender,
            Rv = colors.lavender,
            cv = colors.red,
            ce = colors.red,
            r = colors.teal,
            rm = colors.teal,
            ["r?"] = colors.teal,
            ["!"] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      })

      ins_left({
        "filetype",
        icon_only = true,
      })

      ins_left({
        Util.lualine.pretty_path(),
        cond = conditions.buffer_not_empty,
      })

      ins_left({
        "filesize",
        cond = conditions.buffer_not_empty,
      })

      ins_left({
        "branch",
        icon = icons.git.branch,
      })

      ins_left({
        "diff",
        cond = conditions.hide_in_width,
      })

      ins_right({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = icons.diagnostics.Error,
          warn = icons.diagnostics.Warn,
          info = icons.diagnostics.Info,
        },
      })

      ins_right({
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.bo.filetype
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            ---@diagnostic disable-next-line: undefined-field
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = icons.misc.lsp,
      })

      ins_right({
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
      })

      ins_right({
        "location",
      })

      ins_right({
        "progress",
        padding = { left = 0, right = 1 },
      })

      return config
    end,
  },

  ---------------------------------------------------
  -- nvim-tree/nvim-web-devicons
  -- https://github.com/nvim-tree/nvim-web-devicons
  --
  -- File icons.
  ---------------------------------------------------
  { "nvim-tree/nvim-web-devicons", lazy = true },

  ---------------------------------------------------
  -- MunifTanjim/nui.nvim
  -- https://github.com/MunifTanjim/nui.nvim
  --
  -- UI components
  ---------------------------------------------------
  { "MunifTanjim/nui.nvim", lazy = true },

  ---------------------------------------------------
  -- rcarriga/nvim-notify
  -- https://github.com/rcarriga/nvim-notify
  --
  -- Better `vim.notify()`
  ---------------------------------------------------
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      Util.on_very_lazy(function()
        vim.notify = require("notify")
      end)
    end,
  },

  ---------------------------------------------------
  -- stevearc/dressing.nvim
  -- https://github.com/stevearc/dressing.nvim
  --
  -- Better vim.ui
  ---------------------------------------------------
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
}
