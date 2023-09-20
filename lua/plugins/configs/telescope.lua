local options = {
    -- To actually change any of this we need to wrap the whole thing in the "defaults" property
    defaults = {
        initial_mode = "insert",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
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
            height = 0.8,
        },
        path_display = {"truncate"},
        extensions_list =  {"terms", "fzf"},
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",

            },
        },
    }
}

return options
