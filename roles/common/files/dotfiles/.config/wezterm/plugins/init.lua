local wezterm = require("wezterm")

local M = {}

function M.setup(config)
	local plugins_dir = wezterm.config_dir .. "/plugins"

	for _, file in ipairs(wezterm.glob(plugins_dir .. "/*.lua")) do
		-- Don't load ourselves
		if not file:match("/init%.lua$") then
			local plugin = dofile(file)

			if type(plugin) ~= "table" then
				wezterm.log_error("Invalid plugin file: " .. file)
			elseif not plugin.repo then
				wezterm.log_error("Plugin has no repo: " .. file)
			elseif type(plugin.setup) ~= "function" then
				wezterm.log_error("Plugin has no setup function: " .. file)
			else
				local mod = wezterm.plugin.require(plugin.repo)

				plugin.setup(mod, config)
			end
		end
	end
end

return M
