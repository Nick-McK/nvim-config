local M = {}

_G.last = nil
local function get_new_prompt_height(bo_line, bo_line_side, origin_height)
  bo_line = "╰" .. string.rep("─", #bo_line - 2) .. "╯"
  bo_line_side = "│" .. string.rep(" ", #bo_line_side - 2) .. "│"
  vim.schedule(function()
    local action_state = require("telescope.actions.state")
    local prompt_bufnr = require("telescope.state").get_existing_prompt_bufnrs()[1]

    local picker = action_state.get_current_picker(prompt_bufnr)
    if picker == nil then return
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
        get_new_prompt_height(string.rep(" ", 60), string.rep(" ", 60), 15)
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
