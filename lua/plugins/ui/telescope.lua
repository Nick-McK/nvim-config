return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make"
		}
	},
	opts = function()
		return {
			defaults = {
				initial_mode = "insert",
				sorting_strategy = "ascending",
				layout_strategy = "vertical", -- vertical or horizontal
				color_devicons = true,
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.65,
						results_width = 0.8
					},
					vertical = {
						mirror = false,
						width = 0.5
					},
					width = 0.87,
					height = 0.4,
				},
				-- Set j and k to get next and previous items in insert mode (can still use n and p)
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
				path_display = { "truncate" },
				extensions_list = { "terms", "fzf" },
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = false,
						override_file_sorter = false,
						case_mode = "smart_case",

					},
				},
				file_ignore_patterns = {
					"build",
					"node_modules", -- ignore files inside node_modules
				},
			},
			pickers = {
				-- find_files = {
				-- 	theme = "ivy"
				-- }
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
}
