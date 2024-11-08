local gears = require("gears")

local border_focus = "#ff9e64"
local border_normal = "#3b4261"
local border_width = 2
local border_radius = 20

client.connect_signal("focus", function(c)
	c.border_color = border_focus
	c.bg = "#1a1b26"
end)

client.connect_signal("unfocus", function(c)
	c.border_color = border_normal
	c.bg = "#1f2335"
end)

client.connect_signal("manage", function(c)
	c.border_width = border_width
	c.shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, border_radius)
	end
end)
