local gl = require("galaxyline")
local gl_buffer = require("galaxyline.provider_buffer")
local gl_vcs = require("galaxyline.provider_vcs")
local gl_diagnostic = require("galaxyline.provider_diagnostic")
local gl_fileinfo = require("galaxyline.provider_fileinfo")
local gl_cond = require("galaxyline.condition")
local gl_section = gl.section
local darkside = require("darkside")
local colors = darkside.colors

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

-- Get project's root dit based off .git or fallback to ~
local root_path = function()
	local git_dir_path = gl_vcs.get_git_dir(vim.fn.expand("%:p:h"))
	return not git_dir_path and vim.fn.expand("%:~") or vim.fn.expand("%:p"):sub(git_dir_path:len() - 4)
end

local checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

local has_git_branch = function()
	return gl_buffer.get_buffer_filetype() ~= ""
		and gl_cond.check_git_workspace()
		and gl_vcs.get_git_branch()
		and checkwidth()
end

local set_section = function(name, provider, condition, icon, fg, bg)
	local provider_cb = function(p)
		return function()
			return p and p or " "
		end
	end

	local prov = not provider and provider_cb() or type(provider) == "function" and provider or provider_cb(provider)
	return {
		[name] = {
			provider = prov,
			condition = function()
				if condition then
					return condition()
				end
				return true
			end,
			icon = icon or nil,
			highlight = { fg or colors.dark_gray, bg or colors.dark_gray },
		},
	}
end

local mode_colors = {
	n = colors.blue,
	i = colors.green,
	c = colors.red,
	R = colors.yellow,
	t = colors.gray,
	S = colors.gray,
	s = colors.gray,
	V = colors.cyan,
	v = colors.cyan,
	[""] = colors.cyan,
}

local mode_texts = {
	n = " normal ",
	i = " insert ",
	c = " command ",
	R = " replace ",
	t = " terminal ",
	S = " select  ",
	s = " select ",
	V = " visual ",
	v = " visual ",
	[""] = " visual ",
}

gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

local providers = {
	vi_mode = function()
		vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_colors[vim.fn.mode()])
		return mode_texts[vim.fn.mode()]
	end,
	vi_mode_icon_1 = function()
		vim.api.nvim_command("hi GalaxyViModeIcon_1 guibg=" .. mode_colors[vim.fn.mode()])
		return "   "
	end,
	vi_mode_icon_2 = function()
		vim.api.nvim_command("hi GalaxyViModeIcon_2 guifg=" .. mode_colors[vim.fn.mode()])
		return ""
	end,
	dirty_buf = function()
		return vim.bo.mod and "  +  " or ""
	end,
	git_branch = function()
		vim.api.nvim_command("hi GalaxyGitBranch" .. " guifg=" .. colors.black .. " guibg=" .. colors.gray)
		return "   " .. gl_vcs.get_git_branch() .. " "
	end,
	buffer_type = function()
		return gl_buffer.get_buffer_filetype() ~= ""
				and gl_buffer.get_buffer_filetype() ~= "NVIMTREE"
				and gl_buffer.get_buffer_filetype()
			or ""
	end,
}

local left = {
	set_section("Separator"),
	set_section("ViMode", providers.vi_mode, nil, nil, colors.gray),
	set_section("ViModeIcon_1", providers.vi_mode_icon_1),
	set_section("ViModeIcon_2", providers.vi_mode_icon_2),
	set_section("Separator_2", "    "),
	set_section("FileIcon", gl_fileinfo.get_file_icon, buffer_not_empty, nil, colors.light_gray),
	set_section("FileName", root_path, buffer_not_empty, nil, colors.light_gray),
	set_section("Separator_3"),
	set_section("ModBuffer", providers.dirty_buf, nil, nil, colors.green),
	set_section("Separator_4"),
	set_section("DiagnosticHint", gl_diagnostic.get_diagnostic_hint, nil, "• ", colors.cyan),
	set_section("Separator_5"),
	set_section("DiagnosticError", gl_diagnostic.get_diagnostic_error, nil, "• ", colors.red),
	set_section("Separator_6"),
	set_section("DiagnosticWarn", gl_diagnostic.get_diagnostic_warn, nil, "• ", colors.yellow),
}

local right = {
	set_section("GitBranch", providers.git_branch, has_git_branch),
	set_section("DiffAdd", gl_vcs.diff_add, has_git_branch, "+", colors.green, colors.gray),
	set_section("DiffModified", gl_vcs.diff_modified, has_git_branch, "~", colors.yellow, colors.gray),
	set_section("DiffRemove", gl_vcs.diff_remove, has_git_branch, "-", colors.red, colors.gray),
	set_section("Separator_7", " ", has_git_branch, nil, nil, colors.gray),
	set_section("Separator_8", " ", has_git_branch, nil, nil, colors.dark_gray),
	set_section("Separator_9", "   ", nil, nil, colors.black, colors.gray),
	set_section("LineInfo", gl_fileinfo.line_column, nil, nil, colors.light_gray, colors.gray),
	set_section("Separator_10", " ", nil, nil, colors.light_gray, colors.gray),
	set_section("PerCent", gl_fileinfo.current_line_percent, nil, nil, colors.light_gray, colors.gray),
}

local short_left = {
	set_section("Separator_11", " ", nil, nil, nil, colors.dark_black),
	set_section("BufferType", providers.buffer_type, nil, nil, colors.gray, colors.dark_black),
}

local set_section_position = function(position, config)
	for i, table in ipairs(config) do
		gl_section[position][i] = table
	end
end

set_section_position("left", left)
set_section_position("right", right)
set_section_position("short_line_left", short_left)
