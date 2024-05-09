return {
	"linux-cultist/venv-selector.nvim",
	opts = {
		path = "/home/nick/.pyvenv/",
		parents = "",
		name = { "venv", ".venv" },
		auto_refresh = true
	},
	event = "VeryLazy",
	keys = {
		{ "<leader>vs", "<CMD>VenvSelect<CR>"},
		{ "<leader>vc", "<CMD>VenvSelectCached<CR>" }
	}
}
