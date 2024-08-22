return {
		"numToStr/Comment.nvim",
		opts = function()
			return require("plugins.configs.comment")
		end,
		config = function(_, opts)
			require("Comment").setup({})
		end,
		lazy = false,
	}
