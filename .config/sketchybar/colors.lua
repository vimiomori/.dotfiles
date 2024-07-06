return {
	black = 0xff003955,
	white = 0xff17E3FF,
	red = 0xfffc5d7c,
	green = 0xff30ffc8,
	blue = 0xff0db9d7,
	darkBlue = 0xff003955,
	cyan = 0xff17E3FF,
	teal = 0xff0098B8,
	yellow = 0xffFDFFC4,
	orange = 0xfff39660,
	magenta = 0xffb39df3,
	pink = 0xffFFEBFE,
	grey = 0xff006082,
	transparent = 0x00000000,

	bar = {
		bg = 0xff00283F,
		border = 0xff17E3FF,
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
