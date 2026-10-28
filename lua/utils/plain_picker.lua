local M = {}

local id = vim.api.nvim_create_namespace("TransparentSnacksPicker")
vim.api.nvim_set_hl(id, "TransparentPicker", { bg="none" })
local winhighlight = table.concat({
  "Normal:TransparentPicker",
  "NormalNC:TransparentPicker",
  "NormalFloat:TransparentPicker",
  "WinBar:TransparentPicker",
  "WinBarNC:TransparentPicker",
  "FloatTitle:TransparentPicker",
  "FloatFooter:TransparentPicker",
  "FloatBorder:TransparentPicker",
  "WinSeparator:TransparentPicker",
  "SnacksPickerBorder:TransparentPicker",
}, ",")

local function set_transparent(picker)
  for _, name in ipairs({ "input", "list", "preview" }) do
    local win = picker.layout.wins[name]
    -- print(vim.inspect(picker.layout.box_wins))

    if win and win.win and vim.api.nvim_win_is_valid(win.win) then
      -- require both for saving configs
      win.opts.wo.winhighlight = winhighlight
      -- this one is required because `picker.layout:update()` forces a merge
      -- of `win_opts` and `resize` below calls `update`
      picker.layout.win_opts[name].wo.winhighlight = winhighlight
      -- more stupid highlight groups that need changing
      for _, w in pairs(picker.layout.box_wins) do
        -- print(vim.inspect(w))
        vim.wo[w.win].winhighlight = winhighlight
      end

      vim.api.nvim_set_option_value(
        "winhighlight",
        winhighlight,
        { win = win.win }
      )
    end
  end
end

---@param picker
---@param item
---@param height_opts table<string, int> contains max heights for resizing
local function resize(picker, item, height_opts)
  -- print(vim.inspect(picker.resolved_layout))
  -- print(vim.inspect(picker.layout))

  local height = math.max(1, math.min(#picker.list.items, height_opts.max_height or 10)) + 2 -- think 18 is default max?

  if picker.layout.opts.layout.height == height then
    return
  end

  picker.layout.opts.layout.height = height
  picker.resolved_layout.layout.height = height
  picker.layout:update()
  set_transparent(picker)
end

-- Separate entry point so the existing Snacks picker and mappings stay intact.
-- :lua require("utils.plain_picker").smart()
function M.smart(opts, height_opts)
  local config = vim.tbl_deep_extend("force", {
    matcher = {
      cwd_bonus = true,
      frecency = true
    },
    layout = {
      layout = {
        -- if we set the border to 'none' then we can't render the title, so
        -- set it to whitespace to allow it to render as nothing
        border = {" ", " ", " ", " ", "", "", "", ""},
        -- title = "dick"
      },
      max_height = 10,
      height = 10
    },
    title = "WAHRHSAD",
    debug = { scores = true },
    on_show = set_transparent,
    on_change = function(picker, item)
      resize(picker, item, height_opts or {})
    end
  }, opts or {})

  return Snacks.picker.smart(config)
end

function M.grep(opts, height_opts)
  local config = vim.tbl_deep_extend("force", {
    layout = {
      layout = {
        border = "none",
        winhighlight = winhighlight,
      },
      max_height = 5,
      height = 5
    },
    -- basically none of the `win` callbacks or options do anything for pickers
    -- so using the on_show generically is required
    on_show = set_transparent,
    on_change = function(picker, item) resize(picker, item, height_opts or {}) end
  }, opts or {})

 return Snacks.picker.grep(config)
end

return M
