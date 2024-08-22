return {
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("plugins.configs.bufferline")
		end,
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	}
