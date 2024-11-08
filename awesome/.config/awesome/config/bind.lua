local awful = require("awful")
local helpers = require("helpers")
local kbdcfg = require("config.kb")

local mod = user.mod
local ctrl = "Control"
local shift = "Shift"
local alt = "Mod1"

-- Mouse

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({

		-- Move

		awful.button({ mod }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),

		-- Resize

		awful.button({ mod }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)

-- Keys

awful.keyboard.append_global_keybindings({

	-- Awesome

	awful.key({ mod, shift }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ mod }, "z", function()
		awful.layout.inc(1)
	end, { description = "next layout", group = "awesome" }),
	awful.key({ mod, shift }, "z", function()
		awful.layout.inc(-1)
	end, { description = "previous layout", group = "awesome" }),
	awful.key({ alt }, "Tab", function()
		awful.client.focus.byidx(1)
	end, { description = "next window", group = "awesome" }),
	awful.key({ mod, shift }, "Tab", function()
		awful.client.focus.byidx(-1)
	end, { description = "previous window", group = "awesome" }),
	awful.key({ mod }, "space", function()
		awesome.emit_signal("widget::menu")
	end, { description = "show menu", group = "awesome" }),
	awful.key({ mod }, "d", function()
		awesome.emit_signal("widget::launcher")
	end, { description = "show launcher", group = "awesome" }),
	awful.key({ mod, shift }, "c", function()
		awesome.emit_signal("widget::config")
	end, { description = "show config", group = "awesome" }),
	awful.key({ mod }, "BackSpace", function()
		awesome.emit_signal("widget::lockscreen")
	end, { description = "lock screen", group = "awesome" }),

	--- Client
	--- ~~~~~~
	--- Focus client by direction
	awful.key({ mod }, "k", function()
		awful.client.focus.bydirection("up")
	end, { description = "focus up", group = "client" }),
	awful.key({ mod }, "j", function()
		awful.client.focus.bydirection("down")
	end, { description = "focus down", group = "client" }),
	awful.key({ mod }, "h", function()
		awful.client.focus.bydirection("left")
	end, { description = "focus left", group = "client" }),
	awful.key({ mod }, "l", function()
		awful.client.focus.bydirection("right")
	end, { description = "focus right", group = "client" }),

	-- Resize focused client
	awful.key({ mod, ctrl }, "k", function(_)
		helpers.client.resize_client(client.focus, "up")
	end, { description = "resize to the up", group = "client" }),
	awful.key({ mod, ctrl }, "j", function(_)
		helpers.client.resize_client(client.focus, "down")
	end, { description = "resize to the down", group = "client" }),
	awful.key({ mod, ctrl }, "h", function(_)
		helpers.client.resize_client(client.focus, "left")
	end, { description = "resize to the left", group = "client" }),
	awful.key({ mod, ctrl }, "l", function(_)
		helpers.client.resize_client(client.focus, "right")
	end, { description = "resize to the right", group = "client" }),

	-- Toggle titlebar
	awful.key({ mod, ctrl }, "t", function()
		awful.titlebar.toggle(client.focus)
	end, { description = "toggle title bar", group = "client" }),

	-- Programs

	awful.key({ mod }, "Return", function()
		awful.spawn.with_shell(user.terminal)
	end, { description = "open a terminal", group = "programs" }),
	awful.key({ mod }, "p", function()
		awful.spawn.with_shell("killall picom")
	end, { description = "kill picom", group = "programs" }),
	awful.key({ mod, shift }, "p", function()
		awful.spawn.with_shell("picom & disown")
	end, { description = "start picom", group = "programs" }),

	-- Screenshot

	awful.key({ mod }, "Print", function()
		awesome.emit_signal("util::screenshot", { args = "-u", time = "0" })
	end, { description = "full screen", group = "screenshot" }),
	awful.key({ mod, ctrl }, "Print", function()
		awesome.emit_signal("util::screenshot", { args = "-u", time = "5" })
	end, { description = "full screen delay", group = "screenshot" }),
	awful.key({ mod, shift }, "Print", function()
		awesome.emit_signal("util::screenshot", { args = "-s -u", time = "0" })
	end, { description = "part screen", group = "screenshot" }),

	-- Volume

	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
		awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
		awesome.emit_signal("widget::volume")
	end, { description = "raise volume", group = "volume" }),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
		awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
		awesome.emit_signal("widget::volume")
	end, { description = "lower volume", group = "volume" }),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
		awesome.emit_signal("widget::volume")
	end, { description = "mute volume", group = "volume" }),

	-- Brightness

	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn.with_shell("brightnessctl s 5%+")
		awesome.emit_signal("widget::brightness")
	end, { description = "raise brightness", group = "brightness" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn.with_shell("brightnessctl s 5%-")
		awesome.emit_signal("widget::brightness")
	end, { description = "lower brightness", group = "brightness" }),

	-- Input Layout
	awful.key({ ctrl }, "space", function()
		kbdcfg.switch_next()
	end),

	-- Tag

	awful.key({
		modifiers = { mod },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { mod, ctrl },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { mod, shift },
		keygroup = "numrow",
		description = "move focused client to tag and follow",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
					tag:view_only()
				end
			end
		end,
	}),
})

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({

		-- Client

		awful.key({ mod }, "c", function(c)
			awful.placement.centered(c, { honor_workarea = true })
		end, { description = "center window", group = "client" }),
		awful.key({ mod }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),
		awful.key({ mod }, "s", function(c)
			c.floating = not c.floating
			c:raise()
		end, { description = "toggle floating", group = "client" }),
		awful.key({ mod }, "n", function(c)
			client.focus.minimized = true
		end, { description = "minimize", group = "client" }),
		awful.key({ mod }, "m", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, { description = "toggle maximize", group = "client" }),
		awful.key({ mod }, "b", function(c)
			c.sticky = not c.sticky
			c.above = not c.above
			c:raise()
		end, { description = "toggle sticky", group = "client" }),
		awful.key({ mod, shift }, "q", function(c)
			c:kill()
		end, { description = "close", group = "client" }),

		awful.key({ mod, shift }, "k", function(c)
			helpers.client.move_client(c, "up")
		end),
		awful.key({ mod, shift }, "j", function(c)
			helpers.client.move_client(c, "down")
		end),
		awful.key({ mod, shift }, "h", function(c)
			helpers.client.move_client(c, "left")
		end),
		awful.key({ mod, shift }, "l", function(c)
			helpers.client.move_client(c, "right")
		end),
	})
end)
