local colors = {}
if pcall(require, "darkside") then
	colors = require("darkside").colors
end

local theme = {
	normal = {
		a = { fg = colors.dark_gray, bg = colors.blue },
		b = { fg = colors.light_gray, bg = colors.dark_gray },
		c = { fg = colors.light_gray, bg = colors.dark_black },
		x = { fg = colors.light_gray, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_gray },
	},
	insert = {
		a = { fg = colors.black, bg = colors.green },
		b = { fg = colors.light_gray, bg = colors.dark_gray },
		c = { fg = colors.light_gray, bg = colors.dark_black },
		x = { fg = colors.light_gray, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_gray },
	},
	command = {
		a = { fg = colors.black, bg = colors.red },
		b = { fg = colors.light_gray, bg = colors.dark_gray },
		c = { fg = colors.light_gray, bg = colors.dark_black },
		x = { fg = colors.light_gray, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_gray },
	},
	visual = {
		a = { fg = colors.black, bg = colors.cyan },
		b = { fg = colors.light_gray, bg = colors.dark_gray },
		c = { fg = colors.light_gray, bg = colors.dark_black },
		x = { fg = colors.light_gray, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
	replace = {
		a = { fg = colors.black, bg = colors.red },
		b = { fg = colors.light_gray, bg = colors.dark_gray },
		c = { fg = colors.light_gray, bg = colors.dark_black },
		x = { fg = colors.light_gray, bg = colors.dark_black },
		y = { fg = colors.light_gray, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_black },
	},
	inactive = {
		a = { fg = colors.light_gray, bg = colors.dark_gray },
		b = { fg = colors.white, bg = colors.dark_black },
		c = { fg = colors.black, bg = colors.dark_black },
		z = { fg = colors.light_gray, bg = colors.dark_gray },
	},
}

local setup = {
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		padding = 1,
	},
	sections = {
		lualine_a = { {
			"mode",
			fmt = function()
				return " "
			end,
		} },
		lualine_b = {
			{
				"filename",
				path = 1,
				padding = 2,
				shorting_target = 40,
				symbols = { modified = " [+]", readonly = " [-]", unnamed = "[No Name]" },
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { { "diagnostics", sources = { "nvim_diagnostic" }, padding = 2 } },
		lualine_z = {
			{ "branch", icon = "" },
			{ "diff" },
			{
				"location",
				fmt = function(location)
					return "" .. location
				end,
			},
			{ "progress" },
		},
	},
	inactive_sections = {
		lualine_a = { "filename" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
}

if pcall(require, "lualine") then
	require("lualine").setup(setup)
end
