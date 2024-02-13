local animate = require("mini.animate")
local timing = animate.gen_timing.linear({ duration = 50, unit = "total" })
return {
	cursor = {
		timing = timing,
	},
	scroll = {
		timing = timing,
	},
	open = { enable = false },
	close = { enable = false },
}

