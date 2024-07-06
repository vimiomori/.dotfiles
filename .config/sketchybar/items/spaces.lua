local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

local spaces = {}

for i = 1, 10, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			font = { family = settings.font.numbers },
			string = i,
			padding_left = 5,
			padding_right = 0,
			color = colors.teal,
			highlight_color = colors.green,
		},
		label = {
			padding_left = 2,
			padding_right = 12,
			color = colors.teal,
			highlight_color = colors.cyan,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
		},
		padding_right = 1,
		padding_left = 1,
		width = "dynamic",
		background = {
			color = colors.bar.bg,
			border_width = 1,
			height = 25,
			-- border_color = colors.red,
			padding_left = 1,
			padding_right = 1,
		},
		popup = { background = { border_width = 5, border_color = colors.black } },
	})

	spaces[i] = space

	-- Single item bracket for space items to achieve double border on highlight
	local space_bracket = sbar.add("bracket", { space.name }, {
	  background = {
	    color = colors.transparent,
	    border_color = colors.grey,
	    height = 26,
	    border_width = 1
	  }
	})

	-- Padding space
	-- sbar.add("space", "space.padding." .. i, {
	-- 	space = i,
	-- 	script = "",
	-- 	width = settings.group_paddings,
	-- })

	local space_popup = sbar.add("item", {
		position = "popup." .. space.name,
		padding_left = 5,
		padding_right = 0,
		background = {
			drawing = true,
			image = {
				corner_radius = 9,
				scale = 0.2,
			},
		},
	})

	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = { border_color = selected and colors.black , color = selected and colors.darkBlue },
		})
		space_bracket:set({
		  background = { border_color = selected and colors.grey or colors.bar.bg }
		})
	end)

	space:subscribe("mouse.clicked", function(env)
		if env.BUTTON == "other" then
			space_popup:set({ background = { image = "space." .. env.SID } })
			space:set({ popup = { drawing = "toggle" } })
		else
			local op = (env.BUTTON == "right") and "--destroy" or "--focus"
			sbar.exec("yabai -m space " .. op .. " " .. env.SID)
		end
	end)

	space:subscribe("mouse.exited", function(_)
		space:set({ popup = { drawing = false } })
	end)
end

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

local spaces_indicator = sbar.add("item", {
	padding_left = 0,
	padding_right = 0,
	icon = {
		padding_left = 7,
		padding_right = 9,
		color = colors.cyan,
		string = icons.switch.on,
	},
	label = {
		width = 0,
		padding_left = 0,
		padding_right = 8,
		string = "Menu",
		color = colors.cyan,
	},
	background = {
		color = { alpha = 0.0 },
		border_width = 1,
	},
})

space_window_observer:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	for app, count in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icon_line = icon_line .. " " .. icon
	end

	if no_app then
		icon_line = icons.no_app
	end
	sbar.animate("tanh", 10, function()
		spaces[env.INFO.space]:set({ label = icon_line })
	end)
end)

spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
	local currently_on = spaces_indicator:query().icon.value == icons.switch.on
	spaces_indicator:set({
		icon = currently_on and icons.switch.off or icons.switch.on,
    label = { width = "dynamic", string = currently_on and "Spaces" or "Menu"},
	})
end)

spaces_indicator:subscribe("mouse.entered", function(env)
	sbar.animate("tanh", 10, function()
		spaces_indicator:set({
			-- background = {
			--   color = { alpha = 1.0 },
			--   border_color = { alpha = 1.0 },
			-- },
			-- icon = { color = colors.grey },
			label = { width = "dynamic" },
		})
	end)
end)

spaces_indicator:subscribe("mouse.exited", function(env)
	sbar.animate("tanh", 10, function()
		spaces_indicator:set({
			background = {
				color = { alpha = 0.0 },
			},
			-- icon = { color = colors.green },
			label = { width = 0 },
		})
	end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)
