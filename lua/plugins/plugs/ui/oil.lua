return {
		"stevearc/oil.nvim",
		opts= {},
		config = function (opts)
			return require("oil").setup(opts)
		end,
		keys = {
				{"n", "<CMD>lua require('oil').toggle_float()<CR>", desc="Open File Browser"}
			}
	}
