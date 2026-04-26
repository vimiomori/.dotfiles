local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = false,
	height = 45,
	position = "left",
	color = colors.bar.bg,
	shadow = "on",
	y_offset = 38,
	margin = 7,
	padding_left = 10,
	padding_right = 10,
	corner_radius = 10,
	border_width = 1,
	border_color = colors.cyan,
})
