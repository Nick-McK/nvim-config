return {
	'stevearc/oil.nvim',
    opts = function()
        return {
            columns = {
                "mtime",
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
	end,
  keys = {
    { "<C-n>", function() require("oil").toggle_float() end, desc="Oil"}
  }
}
