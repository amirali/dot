local awful = require("awful")
local kl = require("modules.keyboard_layout")

local kbdcfg = kl.kbdcfg({ type = "tui", tui_wrap_left = "⌨ " })
kbdcfg.add_primary_layout("English", "En", "us")
kbdcfg.add_primary_layout("Persian", "Fa", "ir")
kbdcfg.bind()

kbdcfg.widget:buttons(awful.util.table.join(
	awful.button({}, 1, function()
		kbdcfg.switch_next()
	end),
	awful.button({}, 3, function()
		kbdcfg.menu:toggle()
	end)
))

awesome.connect_signal("kbdcfg::set_english", function()
	kbdcfg.switch_by_name("English")
end)

return kbdcfg
