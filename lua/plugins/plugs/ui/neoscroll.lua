return {
	-- Smooth scrolling animation (needs tested on a vm since mini animate was super janky)
		"karb94/neoscroll.nvim",
		config = function()
			require('neoscroll').setup {}
		end
	}
