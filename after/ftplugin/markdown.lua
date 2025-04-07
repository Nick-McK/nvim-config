local setlocal = vim.opt_local

setlocal.shiftwidth = 2
setlocal.tabstop = 2

-- - [ ] task 1
local function complete_task()
  local win = vim.api.nvim_get_current_win()
  -- local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  if line:find("- [ ] ", 1, true) then
    vim.api.nvim_feedkeys("^f[lrx", "n", true)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    vim.schedule(function()
      line = vim.api.nvim_get_current_line()
      local d = os.date("%d-%m-%y")
      line = line .. " - " .. d
      table.insert(lines, line)
      vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
      vim.api.nvim_del_current_line()
    end)
  elseif line:find("- [x] ", 1, true) then
    -- undo the checkmark
    vim.api.nvim_feedkeys("^fxr ", "n", true)
    -- delete the date appended to the end when its marked as complete
    vim.api.nvim_feedkeys("$3F-hD", "n", true)
    vim.schedule(function()
      line = vim.api.nvim_get_current_line()
      -- vim.api.nvim_del_current_line()
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
      local final_lines = {}
      for i, l in ipairs(lines) do
        if l ~= line then
          if l:find("# TEST") then
            table.insert(final_lines, line)
            table.insert(final_lines, "")
            table.insert(final_lines, l)
          else
            table.insert(final_lines, l)
          end
        end
      end

      vim.api.nvim_buf_set_lines(0, 0, -1, true, final_lines)
    end)
    end
  -- vim.schedule(function()
  --   vim.api.nvim_win_set_cursor(win, {cursor[1], cursor[2]})
  -- end)
end

vim.keymap.set("n", "<leader>c", function() complete_task() end, {})



