local wezterm = require("wezterm")

wezterm.on("format-window-title", function(tab, _, tabs, _, _)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	return "WezTerm:" .. zoomed .. index .. tab.active_pane.title
end)

-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- wezterm.on("gui-startup", function()
-- 	local _, _, window = wezterm.mux.spawn_window({})
-- 	window:gui_window():maximize()
-- end)

return {
	color_scheme = "nord",

	font = wezterm.font_with_fallback({
		"Iosevka",
		"Iosevka Nerd Font",
		"Symbols Nerd Font",
		"Noto Sans",
		"Noto Sans Arabic",
	}),

	font_size = 12.5,

	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 8,
	},

	hide_tab_bar_if_only_one_tab = true,
	harfbuzz_features = {
		"calt=0", -- disable contextual alternates
		"liga=0", -- disable ligatures
	},
	bidi_enabled = true,
	use_fancy_tab_bar = false,
}
