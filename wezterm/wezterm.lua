local wezterm = require("wezterm")

return {
	-- Fonts
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 16.0,
	line_height = 1.2,
	use_fancy_tab_bar = false,
	cursor_blink_rate = 0,
	window_decorations = "TITLE | RESIZE",
	window_padding = { left = 2, right = 2, top = 0, bottom = 0 },
	-- Treat left Option key as Alt modifier with composition effects
	send_composed_key_when_left_alt_is_pressed = true,
	send_composed_key_when_right_alt_is_pressed = false,
	-- Theme -> There's a way to migrate theme config to another file. I might look into this?
	colors = {
		foreground = "#ABB2BF",
		background = "#1E222A",
		cursor_bg = "#4A5261",
		cursor_fg = "#1E222A",
		cursor_border = "#363C48",
		selection_fg = "#1E222A",
		selection_bg = "#E7C788",
		scrollbar_thumb = "#363C48",
		split = "#363C48",

		-- Read more about terminal colors here: https://jeffkreeftmeijer.com/vim-16-color/
		-- { black, read, green, yellow, blue, purple, cyan, white }
		ansi = { "#272B34", "#BE5046", "#67bdc8", "#D19A66", "#61AFEF", "#AE7ABD", "#A3B8EF", "#4A5261" },
		brights = { "#363C48", "#D27E84", "#A3BE8C", "#E7C788", "#61AFEF", "#AE7ABD", "#A3B0EF", "#ABB2BF" },

		tab_bar = {
			background = "#1b1f27",
			active_tab = {
				bg_color = "#272B34",
				fg_color = "#4A5261",
				intensity = "Normal",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = "#1b1f27",
				fg_color = "#363C48",
			},
			inactive_tab_hover = {
				bg_color = "#61AFEF",
				fg_color = "#1b1f27",
			},
			new_tab = {
				bg_color = "#61AFEF",
				fg_color = "#1b1f27",
			},
			new_tab_hover = {
				bg_color = "#61AFEF",
				fg_color = "#1b1f27",
			},
		},
	},
	-- Custom key bindings
	-- disable_default_key_bindings = true,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "_",
			mods = "LEADER",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "w", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
		{ key = "LeftArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "RightArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "UpArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "DownArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
		{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
		{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
		{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
		{ key = "H", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Left", 30 } }) },
		{ key = "L", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Right", 30 } }) },
		{ key = "J", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "{", mods = "LEADER", action = wezterm.action({ MoveTabRelative = -1 }) },
		{ key = "}", mods = "LEADER", action = wezterm.action({ MoveTabRelative = 1 }) },
		{ key = "{", mods = "CTRL|SHIFT", action = wezterm.action({ MoveTabRelative = -1 }) },
		{ key = "}", mods = "CTRL|SHIFT", action = wezterm.action({ MoveTabRelative = 1 }) },
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	},
}
