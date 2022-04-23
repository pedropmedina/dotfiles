local wezterm = require("wezterm")

return {
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 16.0,
	line_height = 1.3,
	use_fancy_tab_bar = false,
	cursor_blink_rate = 0,

	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},

	colors = {
		foreground = "#ABB2BF",
		background = "#1E222A",
		cursor_bg = "#363C48",
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
				bg_color = "#363C48",
				fg_color = "#ABB2BF",
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
				bg_color = "#363C48",
				fg_color = "#ABB2BF",
			},
			new_tab = {
				bg_color = "#A3B0EF",
				fg_color = "#1b1f27",
			},
			new_tab_hover = {
				bg_color = "#A3B0EF",
				fg_color = "#1b1f27",
			},
		},
	},
}
