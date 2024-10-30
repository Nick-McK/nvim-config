return {
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			require "todo-comments".setup({})
		end
	}
