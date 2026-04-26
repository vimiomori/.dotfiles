return {
	black = 0xff003955,
	white = 0xff17E3FF,
	red = 0xffFFCBBA,
	green = 0xff30ffc8,
	blue = 0xff0db9d7,
	darkBlue = 0xff003654,
	cyan = 0xff17E3FF,
	teal = 0xff0098B8,
	darkTeal = 0xff006E87,
	darkHighlight = 0xff004063,
	mint = 0xffb4f9f8,
	yellow = 0xffFDFFC4,
	orange = 0xffFFB9A3,
	magenta = 0xffEBB6FF,
	pink = 0xffFFEBFE,
	grey = 0xff006082,
	transparent = 0x00000000,
	transDark = 0xff0d2d40,

	bar = {
		-- bg = 0xe600283F,
		bg = 0x8000283F,
		-- bg = 0xc000537C,
		border = 0xff003654,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff17E3FF,
	},
	bg1 = 0xff00283F,
	bg2 = 0xff39CDFF,
	bg3 = 0xff006082,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
