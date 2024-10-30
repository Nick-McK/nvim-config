local M = {}

M.toggle_custom_color_col = function()
    local ns_id = vim.api.nvim_create_namespace("colorcolumn_marker")
    -- Define the virtual text to be displayed
    local target_col = 100  -- Desired column for the marker
    local bufnr = vim.api.nvim_get_current_buf()

    -- Clear previous markers in the namespace
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    -- Loop through each line in the buffer
    for i = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, false)[1] or ""
        local line_length = #line

        -- Calculate the amount of padding required to reach the target column
        local padding = math.max(target_col - line_length, 0)
        local padding_spaces = string.rep(" ", padding - 1)  -- Subtract 1 to leave space for the "|"

        -- Set virtual text with padding and the "|" marker
        if line_length < target_col then
            vim.api.nvim_buf_set_extmark(bufnr, ns_id, i, line_length, {
                virt_text = { { padding_spaces .. "│", "NonText" } },
                virt_text_pos = "overlay",
                hl_mode = "combine",
                priority = 0
            })
        else
            local char_at_80 = line:sub(target_col, target_col)
            print("char at 80 '" .. char_at_80 .. "'")
            if char_at_80 == " " then
                -- priority is set to a low value to always draw it first
                -- that way everything else is draw AFTER it
                -- vim.api.nvim_buf_set_extmark(bufnr, ns_id, i, target_col - 1, {
                    --     virt_text = { { padding_spaces .. "│", "NonText" } },
                    --     virt_text_pos = "overlay",
                    --     hl_mode = "combine",
                    --     priority = 0
                    -- })
                    vim.api.nvim_buf_set_extmark(0, ns_id, i, target_col - 1, {
                        virt_text = { { padding_spaces .. "│", "NonText" } },
                        virt_text_pos = 'overlay',         -- Place virtual text at the end of line
                        hl_mode = 'combine',            -- Combine with existing highlights
                        priority = 0,                 -- Higher priority to ensure it is drawn first
                        -- id = 1,                         -- Optional: ID for the extmark
                        -- Adding a negative offset to render it underneath
                        -- virt_lines = { { { '|', 'Normal' } } }, -- Specify the lines as virtual lines
                        -- virt_lines_above = true,       -- Render these below the real text
                    })
            end

        end
    end
end

return M
