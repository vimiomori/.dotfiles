local settings = require("settings")
local colors = require("colors")
local sep = require("separator")

-- day of week
local conf = {
	icon = {
		drawing = false,
	},
	label = {
		color = colors.cyan,
		-- padding_left = 3,
		-- padding_right = 8,
		-- width = 75,
		align = "center",
		font = {
			family = settings.font.number,
			style = settings.font.style_map["Medium"],
			size = 12,
		},
	},
	position = "left",
	update_freq = 120,
	-- padding_left = 10,
	padding_right = 3,
}

local dayOfWeek = sbar.add("item", conf)
local day = sbar.add("item", conf)
local month = sbar.add("item", conf)
sbar.add("item", { padding_right = 3 })

dayOfWeek:subscribe({ "forced", "routine", "system_woke" }, function(env)
	dayOfWeek:set({ label = os.date("%a") })
end)

day:subscribe({ "forced", "routine", "system_woke" }, function(env)
	day:set({ label = os.date("%d") })
end)

month:subscribe({ "forced", "routine", "system_woke" }, function(env)
	month:set({ label = string.upper(tostring(os.date("%b"))) })
end)

sep()
