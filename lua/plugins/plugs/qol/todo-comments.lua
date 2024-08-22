return {
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			return require "plugins.configs.todo_comments"
		end,
		config = function(_, opts)
			require "todo-comments".setup(opts)
		end
	}
