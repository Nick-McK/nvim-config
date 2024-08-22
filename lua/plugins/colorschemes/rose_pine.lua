return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			styles = {
				transparency = false,
				italic = true,
				bold = true,
			}
		})
	end
}
