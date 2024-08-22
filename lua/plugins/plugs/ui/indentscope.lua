return {
		"echasnovski/mini.indentscope",
		opts = function()
			return require("plugins.configs.mini_indentscope")
		end,
		config = function(_, opts)
			return require("mini.indentscope").setup(opts)
		end,
	},
