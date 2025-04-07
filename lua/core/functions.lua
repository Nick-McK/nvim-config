local M = {}

M.state = {
    cc = false,
}

-- TODO: This could be improved by clamping the draw to the height of the current
-- window instead of the entire buffer
M.toggle_custom_color_col = function()
    M.state.cc = true
    local ns_id = vim.api.nvim_create_namespace("colorcolumn_marker")
    -- Define the virtual text to be displayed

    -- Get the currently set colorcolumn value if it exists, if it doesn't
    -- then set it to 80 which is the default
    local cc_val = vim.opt.colorcolumn:get()
    if cc_val[1] == nil then
      cc_val = 80
    else
      cc_val = cc_val[1]
    end
    local bufnr = vim.api.nvim_get_current_buf()
    local winid = vim.api.nvim_get_current_win()
    local target_col = tonumber(cc_val)
    local leftcol = vim.api.nvim_win_call(winid, vim.fn.winsaveview).leftcol or 0


    -- local target_col = 80  -- Desired column for the marker

    -- Clear previous markers in the namespace
    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    -- Loop through each line in the buffer
    for i = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
        local line = vim.api.nvim_buf_get_lines(bufnr, i, i + 1, true)[1]
        -- Add display line length to make sure the column lines up if the line contains chars
        -- that display over more than 1 char space. Ie the "│" char or potentially other unicode characters
        local display_line_length = vim.fn.strdisplaywidth(line)
        -- This is the actual line length taking into account the potentially extra wide characters

        -- Use the display line length as that is the length that is seen in UI
        local padding = math.max(target_col - display_line_length, 0)
        -- local padding_spaces = string.rep(" ", padding)
        if padding > 0 then

          local virt_text = string.rep(" ", padding - 1) .. "│"
          vim.api.nvim_buf_set_extmark(bufnr, ns_id, i, #line, {
            virt_text = { { "│", "NonText" } },
            -- virt_text_pos = "overlay",
            virt_text_win_col = target_col - 1 - leftcol, -- set_extmark is 0 based
            hl_mode = "combine",
            priority = 0,
          })
        else
            -- local byte_index = vim.str_utfindex(line, target_col)
            local char_at_target_col = line:sub(target_col, target_col)
            if char_at_target_col == " " then
                -- priority is set to a low value to always draw it first
                -- that way everything else is draw AFTER it
                --
                -- 0 based indexed function for setting at column. If the line is
                -- < target_col then we - 1 from padding. but this is > target_col
                -- so manually remove 1 from target col to get real target col value
                vim.api.nvim_buf_set_extmark(0, ns_id, i, target_col - 1, {
                    virt_text = { { "│", "NonText" } },
                    -- virt_text_pos = 'overlay',
                    hl_mode = 'combine',
                    priority = 0,
                    virt_text_win_col = target_col - 1 - leftcol
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
_G.last = nil
local function on_complete(bo_line, bo_line_side, origin_height)
  bo_line = "╰" .. string.rep("─", #bo_line - 2) .. "╯"
  bo_line_side = "│" .. string.rep(" ", #bo_line_side - 2) .. "│"
  vim.schedule(function()
    local action_state = require("telescope.actions.state")
    local prompt_bufnr = require("telescope.state").get_existing_prompt_bufnrs()[1]

    local picker = action_state.get_current_picker(prompt_bufnr)
    if picker == nil then
      return
    end
    if not vim.api.nvim_buf_is_valid(picker.results_bufnr) then
      return
    end

    local count = vim.api.nvim_buf_line_count(picker.results_bufnr)
    local top_win = vim.api.nvim_win_get_config(picker.results_win)
    local buttom_buf = vim.api.nvim_win_get_buf(picker.results_win + 1)
    local bottom_win = vim.api.nvim_win_get_config(picker.results_win + 1)
    top_win.height = math.max(count, 1)
    top_win.height = math.min(top_win.height, origin_height)
    bottom_win.height = math.max(count + 2, 3)
    bottom_win.height = math.min(bottom_win.height, origin_height + 2)
    vim.api.nvim_win_set_config(picker.results_win + 1, bottom_win)
    vim.api.nvim_win_set_config(picker.results_win, top_win)
    if _G.last ~= nil then
      vim.api.nvim_buf_set_lines(buttom_buf, _G.last, _G.last + 1, false, { bo_line_side })
    end
    vim.api.nvim_buf_set_lines(buttom_buf, math.max(count + 1, 2), math.max(count + 2, 3), false, { bo_line })
    _G.last = math.max(count + 1, 2)
  end)
end

M.dynamic_height = function()
  -- return require("telescope.builtin").find_files{
    return {
    on_complete = {
      function()
        print("COMPLETING")
        on_complete(string.rep(" ", 60), string.rep(" ", 60), 15)
      end
    },
    layout_strategy = "horizontal",
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    previewer = false,
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        width = 0.35,
        height = 0.7,
      },
      prompt_position = "top",
      mirror = false,
    },
  }
end

return M
