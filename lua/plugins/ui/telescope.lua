function no_preview()
    return require("telescope.themes").get_dropdown({
        borderchars = {
            { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
            prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
            results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
        },
        width = 0.8,

        previewer = false,
        prompt_title = false,
    })
end
local custom_ivy_with_top_preview = function(picker_type)
    local picker = require('telescope.themes').get_ivy {
        prompt_title = "🔍 Ivy Search with Top Preview",
        results_title = "Search Results 📂",
        preview_title = "Preview 📜",
        layout_config = {
            height = 0.3, -- Use 90% of the editor height
            -- width = 0.3, -- Use 90% of the editor width
            prompt_position = "bottom", -- Keep the prompt at the bottom
            preview_cutoff = 1, -- Always show the previewer
            -- preview_height = 0.4, -- Take up 40% of the layout for the previewer
        },
        sorting_strategy = "ascending", -- Results appear top-to-bottom
        border = false, -- Show borders
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- Stylish borders
        -- borderchars = { "", "", "", "", "", "", "", "" }, -- Stylish borders
        winblend = 10, -- Transparency for a modern feel
        previewer = false, -- Enable the previewer
        color_devicons = true, -- Colored file icons
    }

    -- can add custom mappings depending on the picker type this way. Not adding
    -- right now since nothing custom needs done (realised keymap already exists
    -- for deleting buffers)
    -- if picker_type == "buffers" then
    --   picker.mappings = {
    --
    --   }
    -- end

    return picker
end

local custom_live_grep = function()
    return require('telescope.themes').get_dropdown {
        prompt_title = "🔍 Search in Files",
        previewer = true, -- Disable preview to make it compact
        results_title = "Search Results 📂",
        layout_config = {
            width = 0.7, -- 70% of the editor width
            height = 0.5, -- 50% of the editor height
            prompt_position = "top", -- Keep the prompt at the top
        },
        sorting_strategy = "ascending", -- Results appear top-to-bottom
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- Stylish borders
        winblend = 15, -- Slight transparency for a modern look
        border = true, -- Show borders around the picker
    }
end

-- TODO: Add git commands - can use the previewer to look at diffs which would save time

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
				layout_strategy = "horizontal", -- bottom_pane
				color_devicons = true,
        preview = false,
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
                -- previewer = true,
				mappings = {
					i = {
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
					},
				},
				path_display = { "truncate" },
				-- path_display = { "filename_first" },
				extensions_list = { "terms", "fzf" },
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = false,
						case_mode = "smart_case",
					},
				},
				file_ignore_patterns = {
					"build/",
					"node_modules", -- ignore files inside node_modules
				},
      },
      pickers = {
        -- find_files = { previewer = false, preview_width = 50 },
        -- find_files = require("telescope.builtin").find_files(dynamic_height()),
        buffers = custom_ivy_with_top_preview("buffers"),
        marks = no_preview(),
        live_grep = custom_ivy_with_top_preview("live_grep"),
      },
    }
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
}
