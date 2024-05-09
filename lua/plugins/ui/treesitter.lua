return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	opts = function()
		return {
			ensure_installed = {
				"lua",
				"python",
				"javascript",
				"typescript",
				"go",
				"cpp",
			},
			auto_install = true,
			highlight = {
				enable = true,
				use_languagetree = true,
			},
			indent = {enable = true},
		}
	end,
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,

}
