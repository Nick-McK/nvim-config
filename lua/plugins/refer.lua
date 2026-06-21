local function update_frecency_blink(selection)
  if type(selection) == "table" then
    if not selection.text or selection.text == "" then
      vim.notify("refer(frecency): unlikely to be accessing frecency database. Incorrect selection format")
    end
  elseif type(selection) == "string" then
    if selection == "" then
      vim.notify("refer(frecency): selection string empty")
    end
  end

  local ok, fuzzy = pcall(require, "blink.cmp.fuzzy")
  if not ok then
    vim.notify("NO BLINK FUZ", vim.log.levels.ERROR)
    return
  end

  -- This function updates the frecency database
  fuzzy.access({
    label = selection.text or selection,
    filterText = selection.text or selection,
    sortText = selection.text or selection,
    insertText = selection.text or selection,
    kind = 1,
    score_offset = 0,
    source_id = "refer",
    source_name = "refer"
  })
end

local blink_mod = nil
local blink_available = nil

local cached_len = -1
local cached_first = nil
local cached_last = nil
local cached_blink_items = nil

local provider_id = "refer"

local function get_blink()
  if blink_available ~= nil then
    return blink_available and blink_mod or nil
  end

  local ok, mod = pcall(require, "refer.blink")
  if not ok or not mod.is_available() then
    blink_available = false
    return nil
  end

  blink_mod = mod
  blink_available = true
  return blink_mod
end

local function items_changed(items)
  local len = #items

  return len ~= cached_len
    or items[1] ~= cached_first
    or items[len] ~= cached_last
end

local function set_items_for_blink(blink, items)
  local blink_items = {}

  for i = 1, #items do
    local item = items[i]

    blink_items[i] = {
      label = item,
      filterText = item,
      sortText = item,
      insertText = item,
      kind = 1,
      score_offset = 0,
      source_id = provider_id,
      source_name = provider_id,
    }
  end

  cached_len = #items
  cached_first = items[1]
  cached_last = items[#items]
  cached_blink_items = blink_items

  blink.set_provider_items(provider_id, cached_blink_items)
end

local function blink_frecency(items, query)
  if query == "" then
    return items
  end

  local blink = get_blink()
  if not blink then
    return items
  end

  if items_changed(items) then
    set_items_for_blink(blink, items)
  end

  local _, idxs = blink.fuzzy(query, provider_id)
  if not idxs then
    return {}
  end

  local out = {}

  for i = 1, #idxs do
    out[i] = items[idxs[i] + 1]
  end

  return out
end


return {
  "juniorsundar/refer.nvim",
  dependencies = {
    -- Optional: specific fuzzy libs if you want to override defaults
    -- "nvim-mini/mini.fuzzy",
  },
  config = function()
    vim.g.refer_show_ignored = false
    local refer = require("refer")
    refer.setup({
      -- General Settings
      max_height_percent = 0.4,-- Window height as a percentage of editor height
      min_height = 1,         -- Minimum window height in lines

      -- Async Settings
      debounce_ms = 100,      -- Delay for async searching (files/grep)
      min_query_len = 2,      -- Minimum characters to start async search

      custom_sorters = {
        blink_frecency = blink_frecency
      },

      -- Sorting
      available_sorters = {"blink_frecency", "blink", "native"},
      default_sorter = "blink_frecency",
      preview = {
        enabled = true,     -- Enable/Disable preview by default
        max_lines = 300,   -- Max lines to read for preview (performance)
      },

      -- Provider Configuration
      providers = {
        files = {
          -- Custom ignored directories for 'Files' picker
          ignored_dirs = { ".git", ".jj", "node_modules", ".cache" },

          -- Custom find because debian uses fdfind not fd
          -- Refer returns early without using the ignored_dirs when using a custom func so define again
          find_command = function(query)
            local ignored_dirs = { ".git", ".jj", "node_modules", ".cache" }
            local cmd = { "fdfind", "-H", "--type", "f", "--color", "never"}
            if not vim.g.refer_show_ignored then
              for _, dir in ipairs(ignored_dirs) do
                table.insert(cmd, "--exclude")
                table.insert(cmd, dir)
              end
            end
            return cmd
          end
        },
        grep = {
          -- Custom rg command
          grep_command = { "rg", "--vimgrep", "--smart-case" },
        },
      },

      -- Default Keymaps
      keymaps = {
        ["Tab>"] = "complete_selection",
        ["<C-j>"] = "next_item",
        ["<C-k>"] = "prev_item",
        ["<Down>"] = "next_item",
        ["<Up>"] = "prev_item",
        ["<CR>"] = "select_input",
        -- Select input and update the frecency
        ["<C-space>"] = function (selection, builtin)
          update_frecency_blink(selection) -- otherwise the frecency won't work
          builtin.actions.select_entry()
        end,
        ["<Esc>"] = "close",
        ["<C-c>"] = "close",
        ["<C-g>"] = "send_to_grep",
        ["<C-q>"] = "send_to_qf",
        ["<C-s>"] = "cycle_sorter",
        ["<C-v>"] = "toggle_preview",
        ["<C-u>"] = "scroll_preview_up",
        ["<C-d>"] = "scroll_preview_down",
        ["<C-a>"] = "select_all",
        ["<C-x>"] = "deselect_all",
        ["<M-t>"] = "toggle_all",
        -- Toggle hidden files
        ["<M-i>"] = function(selection, builtin)
          vim.g.refer_show_ignored = not vim.g.refer_show_ignored
          if builtin and builtin.actions and builtin.actions.refresh then
            builtin.actions.refresh()
          end
        end

      },
    })
  end
}
