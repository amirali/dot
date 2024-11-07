local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local pampath = require("gears").filesystem.get_configuration_dir() .. "liblua_pam.so"

-- Authentication

local authenticate
awful.spawn.easy_async_with_shell("stat "..pampath.." >/dev/null 2>&1", function (_, _, _, exitcode)
	if exitcode == 0 then
		authenticate = function(password)
			return password == user.passwd
		end
		local pam = require("liblua_pam")
		authenticate = function(password)
			return pam.auth_current_user(password)
		end
	else
		authenticate = function(password)
			return password == user.passwd
		end
	end
end)

-- Variables

local characters = 0

-- Background

screen.connect_signal("request::desktop_decoration", function(s)
	local background = wibox {
		screen = s,
		visible = false,
		ontop = true,
		type = "splash",
		widget = live(wibox.container.background, { bg = "bg" })
	}

	awful.placement.maximize(background)

	local batterypercent = wibox.widget {
		text = "N/A",
		widget = wibox.widget.textbox
	}

	local battery = wibox.widget {
		{
			batterypercent,
			top = dpi(5),
			bottom = dpi(5),
			left = dpi(8),
			right = dpi(8),
			widget = wibox.container.margin
		},
		shape = function(cr, width, height)
					gears.shape.rounded_rect(cr, width, height, dpi(10))
				end,
		widget = live(wibox.container.background, { bg = "bgmid", fg = "fg" })
	}

	if user.batt ~= nil then
		awful.widget.watch("cat /sys/class/power_supply/" .. user.batt .. "/capacity", 15, function(widget, stdout)
			batterypercent.text = tonumber(stdout) .. "%"
		end)
	end

	if s == awful.screen.focused() then
		background:setup {
			{
				{
					{
						{
							{
								{
									wibox.widget.textbox("Lock Screen"),
									top = dpi(5),
									bottom = dpi(5),
									left = dpi(8),
									right = dpi(8),
									widget = wibox.container.margin
								},
								shape = function(cr, width, height)
											gears.shape.rounded_rect(cr, width, height, dpi(10))
										end,
								widget = live(wibox.container.background, { bg = "bgmid", fg = "fg" })
							},
							nil,
							{
								battery,
								{
									{
										wibox.widget.textclock('%I:%M %p'),
										top = dpi(5),
										bottom = dpi(5),
										left = dpi(8),
										right = dpi(8),
										widget = wibox.container.margin
									},
									shape = function(cr, width, height)
												gears.shape.rounded_rect(cr, width, height, dpi(10))
											end,
									widget = live(wibox.container.background, { bg = "bgmid", fg = "fg" })
								},
								spacing = dpi(5),
								layout = wibox.layout.fixed.horizontal
							},
							layout = wibox.layout.align.horizontal
						},
						{
							{
								button {
									type = "text", 
									image = "", 
									run = function() 
										awful.spawn.with_shell(user.shutdown)
									end
								},
								button {
									type = "text", 
									image = "", 
									run = function() 
										awful.spawn.with_shell(user.reboot)
									end
								},
								button {
									type = "text", 
									image = "", 
									run = function() 
										awesome.quit()
									end
								},
								spacing = dpi(5),
								layout = wibox.layout.fixed.horizontal
							},
							halign = "center",
							widget = wibox.container.place
						},
						layout = wibox.layout.stack
					},
					forced_height = dpi(50),
					margins = dpi(10),
					widget = wibox.container.margin
				},
				valign = "bottom",
				content_fill_horizontal = true,
				widget = wibox.container.place
			},
			widget = live(wibox.container.background , { bg = "bg" })
		}
	end

	local wallpaper = wibox {
		screen = awful.screen.focused(),
		width = s.geometry.width-dpi(20),
		height = s.geometry.height-dpi(60),
		ontop = true,
		visible = false,
		type = "normal",
		widget = wibox.widget {
			image = gears.surface.crop_surface {
				surface = gears.surface.load_uncached(beautiful.wallpaper),
				ratio = (s.geometry.width-dpi(20))/(s.geometry.height-dpi(60))
			},
			widget = wibox.widget.imagebox
		}
	}

	awful.placement.top(
		wallpaper,
		{
			margins = {
				top = dpi(10)
			}
		}
	)

	awesome.connect_signal("live::reload", function()
		wallpaper.widget = wibox.widget {
			image = gears.surface.crop_surface {
				surface = gears.surface.load_uncached(beautiful.wallpaper),
				ratio = (s.geometry.width-dpi(20))/(s.geometry.height-dpi(60))
			},
			widget = wibox.widget.imagebox
		}
	end)

	awesome.connect_signal("lockscreen::visible", function(v)
		background.visible = v
		wallpaper.visible = v
	end)
end)

-- Prompt

local prompt = wibox.widget {
	font = user.font,
	align = "center",
	widget = colortext({ text = "Enter Password", fg = "fg" })
}

local promptbox = wibox {
	width = dpi(350),
	height = dpi(135),
	ontop = true,
	visible = false
}

awful.spawn.easy_async_with_shell("getent passwd $(whoami) | cut -d ':' -f 5", function(out)
	promptbox:setup {
		{
			{
				{
					{
						{
							live(wibox.widget.imagebox, { image = "calla" }),
							forced_height = dpi(24),
							margins = dpi(5),
							widget = wibox.container.margin
						},
						shape = function(cr, width, height)
									gears.shape.rounded_rect(cr, width, height)
								end,
						widget = live(wibox.container.background, { bg = "bgmid" })
					},
					{
						font = user.font:gsub("%d+", "24"),
						widget = colortext({ text = out:gsub(",", ""):gsub("\n", "") })
					},
					spacing = dpi(10),
					layout = wibox.layout.fixed.horizontal
				},
				{
					{
						{
							prompt,
							layout = wibox.layout.fixed.horizontal
						},
						top = dpi(10),
						bottom = dpi(10),
						left = dpi(15),
						right = dpi(15),
						forced_height = dpi(40),
						forced_width = dpi(300),
						widget = wibox.container.margin
					},
					shape = function(cr, width, height)
								gears.shape.rounded_rect(cr, width, height, dpi(10))
							end,
					widget = live(wibox.container.background, { bg = "bgmid" })
				},
				spacing = dpi(10),
				layout = wibox.layout.fixed.vertical
			},
			valign = "center",
			halign = "center",
			layout = wibox.container.place
		},
		widget = live(wibox.container.background, { bg = "bg" })
	}
end)

awful.placement.centered(promptbox)

awesome.connect_signal("lockscreen::visible", function(v)
	promptbox.visible = v
end)

-- Reset

local function reset()
	characters = 0;
	prompt.markup = markup({ text = "Enter Password", fg = "fg" })
	--awful.spawn.with_shell("pkill --full --uid " .. os.getenv("USER") .. " fprintd-verify")
end

-- Fail

local function fail()
	characters = 0;
	prompt.markup = markup({ text = "Try Again", fg = "fg" })
end

-- Input

local function grabpassword()
	awful.prompt.run {
		hooks = {
			{{ }, 'Escape', function(_)
					reset()
					grabpassword()
				end
			}
		},
		keypressed_callback  = function(mod, key, cmd)
			if #key == 1 then
				characters = characters + 1
				prompt.markup = markup({ text = string.rep("", characters), fg = "fg" })
			elseif key == "BackSpace" then
				if characters > 1 then
					characters = characters - 1
					prompt.markup = markup({ text = string.rep("", characters), fg = "fg" })
				else
					characters = 0
					prompt.markup = markup({ text = "Enter Password", fg = "fg" })
				end
			end
		end,
		exe_callback = function(input)
			if authenticate(input) then
				reset()
				awesome.emit_signal("lockscreen::visible", false)
			else
				fail()
				grabpassword()
			end
		end,
		textbox = wibox.widget.textbox()
	}

	--[[awful.spawn.easy_async("fprintd-verify", function(out)
		if out:match("verify%-match") then
			awful.keygrabber.stop()
			reset()
			awesome.emit_signal("lockscreen::visible", false)
		elseif out:match("verify%-no%-match") then
			awful.keygrabber.stop()
			fail()
			grabpassword()
		elseif out:match("already claimed") then
			awful.keygrabber.stop()
			reset()
			grabpassword()
		elseif out:match("verify%-unknown%-error") or out:match("already been opened") then
			require("naughty").notification{text="It appears that fprintd has encountered an error because of a suspend. Please enter password manually.",urgency="critical"}
		end
	end)--]]
end

-- Lock

awesome.connect_signal("widget::lockscreen", function()
	awesome.emit_signal("lockscreen::visible", true)
	grabpassword()
end)
