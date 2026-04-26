local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local sep = require("separator")
local app_icons = require("helpers.app_icons")

local spaces = {}
-- local spacesNames = {}
-- local brackets = {}

-- local ordered = {
-- 	colors.pink,
-- 	colors.yellow,
-- 	colors.green,
-- 	colors.cyan,
-- 	colors.pink,
-- 	colors.red,
-- 	colors.yellow,
-- 	colors.green,
-- 	colors.blue,
-- }

for i = 1, 10, 1 do
	local space = sbar.add("space", "space." .. i, {
		space = i,
		icon = {
			drawing = false,
			-- font = { family = settings.font.numbers },
			-- string = i,
			-- padding_left = 0,
			-- padding_right = 0,
			-- color = ordered[i],
			-- highlight_color = colors.darkTeal,
			-- -- highlight_color = ordered[i],
		},
		label = {
			-- padding_left = 0,
			padding_right = 8,
			align = "center",
			color = colors.cyan,
			highlight_color = colors.yellow,
			-- highlight_color = ordered[i],
			font = "sketchybar-app-font:Regular:16.0",
			-- y_offset = -1,
		},
		padding_right = 4,
		padding_left = 4,
		-- width = "dynamic",
		position = "left",
		-- background = {
		-- 	color = colors.transparent,
		-- 	-- border_color = colors.black,
		-- 	border_width = 2,
		-- 	-- height = 27,
		-- 	-- padding_left = 1,
		-- 	-- padding_right = 1,
		-- },
		popup = { background = { border_width = 5, border_color = colors.black } },
	})

	spaces[i] = space
	-- spacesNames[i] = space.name

	-- Single item bracket for space items to achieve double border on highlight
	-- local space_bracket = sbar.add("bracket", "bracket." .. i, { space.name }, {
	-- 	background = {
	-- 		color = colors.transparent,
	-- 		-- border_color = colors.red,
	-- 		height = 22,
	-- 		border_width = 1,
	-- 	},
	-- })
	-- brackets[i] = space_bracket.name
	--
	-- Padding space
	-- sbar.add("space", "space.padding." .. i, {
	-- 	space = i,
	-- 	script = "",
	-- 	width = settings.group_paddings,
	-- })

	-- local space_popup = sbar.add("item", {
	-- 	position = "popup." .. space.name,
	-- 	padding_left = 5,
	-- 	padding_right = 0,
	-- 	background = {
	-- 		drawing = true,
	-- 		image = {
	-- 			corner_radius = 9,
	-- 			scale = 0.2,
	-- 		},
	-- 	},
	-- })
	--
	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		space:set({
			icon = { highlight = selected },
			-- icon = { highlight = selected},
			label = { highlight = selected },
			-- background = {
			-- 	padding_right = selected and 1 or 0,
			-- 	padding_left = selected and 1 or 0,
			-- 	border_color = selected and colors.darkTeal,
			-- 	border_width = 1,
			-- 	height = 21,
			-- 	color = selected and colors.cyan,
			-- 	-- color = colors.transparent,
			-- },
		})
		-- space_bracket:set({
		-- 	background = {
		-- 		border_color = selected and colors.darkBlue,
		-- 		border_width = 1,
		-- 		height = 32,
		-- 		-- color = selected and colors.cyan,
		-- 	},
		-- })
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

-- sbar.add("bracket", spacesNames, {
-- 	background = {
-- 		color = colors.transparent,
-- 		border_color = colors.grey,
-- 		height = 27,
-- 		border_width = 1,
-- 		-- padding_left = 100,
-- 		-- padding_right = 10,
-- 	},
-- })

-- sbar.add("bracket", "bracket", brackets, {
-- 	position = "center",
-- 	background = {
-- 		color = colors.darkBlue,
-- 		height = 27,
-- 		border_color = colors.darkHighlight,
-- 		border_width = 2,
-- 		-- padding_left = 10,
-- 	},
-- })

local space_creator = sbar.add("item", {
	position = "left",
	padding_left = 10,
	padding_right = 8,
	icon = {
		string = "+",
		font = {
			style = "Heavy",
			size = 16.0,
		},
	},
	label = { drawing = false },
	associated_display = "active",
})

sep()

space_creator:subscribe("mouse.clicked", function(_)
	sbar.exec("yabai -m space --create")
end)

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

-- local spaces_indicator = sbar.add("item", {
-- 	position = "center",
-- 	padding_left = 0,
-- 	padding_right = 0,
-- 	icon = {
-- 		padding_left = 7,
-- 		padding_right = 9,
-- 		color = colors.cyan,
-- 		string = icons.switch.on,
-- 	},
-- 	label = {
-- 		width = 0,
-- 		padding_left = 0,
-- 		padding_right = 8,
-- 		string = "Menu",
-- 		color = colors.cyan,
-- 	},
-- 	background = {
-- 		color = { alpha = 0.0 },
-- 		border_width = 1,
-- 	},
-- })

space_window_observer:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	-- local padding_left = 0
	for app, count in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icon_line = icon_line .. " " .. icon
	end

	if no_app then
		icon_line = icons.no_app
		-- padding_left = 6
	end
	sbar.animate("tanh", 10, function()
		spaces[env.INFO.space]:set({
			label = {
				string = icon_line,
				padding_left = no_app and 6 or 0,
				color = no_app and colors.darkTeal or colors.cyan,
				-- padding_left = 8,
				-- y_offset = icon_offset,
			},
		})
	end)
end)

-- spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
-- 	local currently_on = spaces_indicator:query().icon.value == icons.switch.on
-- 	spaces_indicator:set({
-- 		icon = currently_on and icons.switch.off or icons.switch.on,
-- 		label = { width = "dynamic", string = currently_on and "Spaces" or "Menu" },
-- 	})
-- end)
--
-- spaces_indicator:subscribe("mouse.entered", function(env)
-- 	sbar.animate("tanh", 10, function()
-- 		spaces_indicator:set({
-- 			-- background = {
-- 			--   color = { alpha = 1.0 },
-- 			--   border_color = { alpha = 1.0 },
-- 			-- },
-- 			-- icon = { color = colors.grey },
-- 			label = { width = "dynamic" },
-- 		})
-- 	end)
-- end)
--
-- spaces_indicator:subscribe("mouse.exited", function(env)
-- 	sbar.animate("tanh", 10, function()
-- 		spaces_indicator:set({
-- 			background = {
-- 				color = { alpha = 0.0 },
-- 			},
-- 			-- icon = { color = colors.green },
-- 			label = { width = 0 },
-- 		})
-- 	end)
-- end)
--
-- spaces_indicator:subscribe("mouse.clicked", function(env)
-- 	sbar.trigger("swap_menus_and_spaces")
-- end)
