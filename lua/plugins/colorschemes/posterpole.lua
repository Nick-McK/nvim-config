return {
	"ilof2/posterpole.nvim",
	priority=999,
	config = function ()
		require("posterpole").setup({
			-- config here
		})
		vim.cmd("colorscheme posterpole")
        vim.api.nvim_set_hl(0, "Normal", {bg="#111111"})
        vim.api.nvim_set_hl(0, "NormalNC", {bg="#111111"})
        vim.api.nvim_set_hl(0, "EndOfBuffer", {bg="#111111"})
        --
        -- This is applied to every colourscheme at the moment
        --
        vim.api.nvim_create_autocmd("ColorScheme",{
            callback = function()
              -- print("color" .. vim.g.colors_name)
            end,
        })

	end
}
