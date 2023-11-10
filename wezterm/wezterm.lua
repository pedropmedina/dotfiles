local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Fonts
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16.0
config.line_height = 1.2
config.use_fancy_tab_bar = false
config.cursor_blink_rate = 0

-- Window look and feel
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { left = 2, right = 0, top = 0, bottom = 0 }

-- Treat left Option key as Alt modifier with composition effects
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false

-- Hiding tab bar with native buttons overlaps content
config.hide_tab_bar_if_only_one_tab = false

-- Hide button that creates new tab. Use cmd + t instead
config.show_new_tab_button_in_tab_bar = false

-- Increase tab width. Default is 16
config.tab_max_width = 30

-- Handler for changes within tab title event
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return "(" .. tab_info.tab_index .. ")" .. title
	end
	-- Otherwise, use the title from the active pane
	return "(" .. tab_info.tab_index .. ")" .. tab_info.active_pane.title
end

-- Prefix active tab title with '*'
wezterm.on("format-tab-title", function(tab)
	local title = tab_title(tab)
	if tab.is_active then
		return { { Text = "*" .. title .. "  " } }
	end
	return title .. "  "
end)

-- Customize some of Catppuccin scheme colors
local cm = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
cm.tab_bar.background = "#1e1e2e"
cm.tab_bar.inactive_tab.bg_color = "#1e1e2e"
cm.tab_bar.inactive_tab.fg_color = "#313244"
cm.tab_bar.active_tab.bg_color = "#1e1e2e"
cm.tab_bar.active_tab.fg_color = "#f5c2e7"

-- Set custom theme
config.color_schemes = { ["cm"] = cm }
config.color_scheme = "cm"

-- Key bindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "|", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "_", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
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
	{
		key = "R",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

return config
