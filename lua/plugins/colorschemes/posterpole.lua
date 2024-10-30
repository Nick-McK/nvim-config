return {
	"ilof2/posterpole.nvim",
	priority=1000,
	config = function ()
		require("posterpole").setup({
			-- config here
		})
		vim.cmd("colorscheme posterpole")
	end
}
