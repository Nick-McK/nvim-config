local M = {}

M.state = {
    cc = false,
}

M.toggle_custom_color_col = function()
    M.state.cc = true
    -- TODO: This should be called when we go into insert mode? So we don't get the weird UI bugs
    -- that happen when you delete a line and then virtual whitespace covers a line with text on it
    local ns_id = vim.api.nvim_create_namespace("colorcolumn_marker")
    -- Define the virtual text to be displayed
    local target_col = 90  -- Desired column for the marker
    local bufnr = vim.api.nvim_get_current_buf()

    -- Clear previous markers in the namespace
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    -- Loop through each line in the buffer
    for i = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, true)[1]
        -- Add display line length to make sure the column lines up if the line contains chars
        -- that display over more than 1 char space. Ie the "│" char or potentially other unicode characters
        local display_line_length = vim.fn.strdisplaywidth(line)
        -- This is the actual line length taking into account the potentially extra wide characters
        local line_length = #line

        -- Use the display line length as that is the length that is seen in UI
        local padding = math.max(target_col - display_line_length, 0)
        local padding_spaces = string.rep(" ", padding - 1)

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
            if char_at_80 == " " then
                -- priority is set to a low value to always draw it first
                -- that way everything else is draw AFTER it
                vim.api.nvim_buf_set_extmark(0, ns_id, i, target_col, {
                    virt_text = { { padding_spaces .. "│", "NonText" } },
                    virt_text_pos = 'overlay',
                    hl_mode = 'combine',
                    priority = 0,
                })
            end
        end
    end
end

M.clear_custom_color_col = function()
    local ns_id = vim.api.nvim_create_namespace("colorcolumn_marker")
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
    M.state.cc = false

end

return M
