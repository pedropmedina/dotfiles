local keymapper = {}

local keymapper_options = {}

function keymapper_options:new()
  local instance = {
    cmd = '',
    options = {
      noremap = false,
      silent = false,
      expr = false,
    }
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function keymapper_options:map_cmd(cmd_string)
  self.cmd = cmd_string
  return self
end

function keymapper_options:map_cr(cmd_string)
  self.cmd = (":%s<CR>"):format(cmd_string)
  return self
end

function  keymapper_options:map_args(cmd_string)
  self.cmd = (":%s<Space>"):format(cmd_string)
  print(vim.inspect(self.cmd))
  return self
end

function keymapper_options:map_cu(cmd_string)
  self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
  return self
end

function keymapper_options:with_silent()
  self.options.silent = true
  return self
end

function keymapper_options:with_noremap()
  self.options.noremap = true
  return self
end

function keymapper_options:with_expr()
  self.options.expr = true
  return self
end

function keymapper.map_cr(cmd_string)
  local ro = keymapper_options:new()
  return ro:map_cr(cmd_string)
end

function keymapper.map_cmd(cmd_string)
  local ro = keymapper_options:new()
  return ro:map_cmd(cmd_string)
end

function keymapper.map_cu(cmd_string)
  local ro = keymapper_options:new()
  return ro:map_cu(cmd_string)
end

function keymapper.map_args(cmd_string)
  local ro = keymapper_options:new()
  return ro:map_args(cmd_string)
end

function keymapper.nvim_load_mapping(mapping)
    for key, value in pairs(mapping) do
      local mode, keymap = key:match("([^|]*)|?(.*)")
      if type(value) == 'table' then
        local rhs = value.cmd
        local options = value.options
        vim.fn.nvim_set_keymap(mode, keymap, rhs, options)
      end
    end
end

return keymapper
