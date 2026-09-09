local wezterm = require("wezterm")
local plugins = require("plugins")

local config = wezterm.config_builder()

-- Base configuration
for key, value in pairs(require("config")) do
	config[key] = value
end

-- Plugins
plugins.setup(config)

config.use_fancy_tab_bar = false

return config
