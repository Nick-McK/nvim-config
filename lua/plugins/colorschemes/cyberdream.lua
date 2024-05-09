return {
	"scottmckendry/cyberdream.nvim",
	event = "VeryLazy",
	config = function()
		require("cyberdream").setup({
			transparent=true,
			italic_comments = true,
			borderless_telescope = false,
		})
	end
}
