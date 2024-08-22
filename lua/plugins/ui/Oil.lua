return {
	'stevearc/oil.nvim',
    opts = function()
        return {
            columns = {
                "icon",
                "size",
                "type",
            },
            view_options = {
                show_hidden = true,
            }

        }
    end,
	config = function(_, opts)
		require("oil").setup(opts)
	end
}
