local function update_frecency_blink(selection)
  if type(selection) ~= "string" or selection == "" then
    vim.notify("NO SELECTION", vim.log.levels.ERROR)
    return
  end

  local ok, fuzzy = pcall(require, "blink.cmp.fuzzy")
  if not ok then
    vim.notify("NO BLINK FUZ", vim.log.levels.ERROR)
    return
  end

  -- This function updates the frecency database
  fuzzy.access({
    label = selection,
    filterText = selection,
    sortText = selection,
    insertText = selection,
    kind = 1,
    score_offset = 0,
    source_id = "refer",
  })
end

return {
  "juniorsundar/refer.nvim",
  dependencies = {
    -- Optional: specific fuzzy libs if you want to override defaults
    -- "nvim-mini/mini.fuzzy",
  },
  config = function()
    local refer = require("refer")
    refer.setup({
      -- General Settings
      max_height_percent = 0.4,-- Window height as a percentage of editor height
      min_height = 1,         -- Minimum window height in lines

      -- Async Settings
      debounce_ms = 10,      -- Delay for async searching (files/grep)
      min_query_len = 2,      -- Minimum characters to start async search

      custom_sorters = {
        blink_frecency = function(items, query)
          local blink_ok, blink = pcall(require, "refer.blink")
          if not blink_ok then return items end
          if not blink.is_available() then return items end

          local blink_items = {}
          for _, item in ipairs(items) do
            blink_items[#blink_items + 1] = {
              label = item,
              filterText = item,
              sortText = item,
              insertText = item,
              kind = 1,
              score_offset = 0,
              source_id = "refer",
            }
          end

          blink.set_provider_items("refer", blink_items)
          local _, idxs = blink.fuzzy(query, "refer")
          if not idxs then return {} end

          local out = {}
          for _, idx in ipairs(idxs) do
            out[#out + 1] = items[idx + 1]
          end
          return out
        end
      },

      -- Sorting
      -- available_sorters = { "blink_frecency", "blink", "mini", "native", "lua" },
      available_sorters = {"blink_frecency", "blink"},
      default_sorter = "blink_frecency", -- Default sorter for static lists.
      -- If blink.cmp isn't installed, it will download
      -- the compiled library using `curl`.

      -- Preview Settings
      preview = {
        enabled = true,     -- Enable/Disable preview by default
        max_lines = 1000,   -- Max lines to read for preview (performance)
      },

      -- UI Customization
      ui = {
        mark_char = "●",
        mark_hl = "String",
        winhighlight = "Normal:Normal,FloatBorder:Normal,WinSeparator:Normal,StatusLine:Normal,StatusLineNC:Normal",
        highlights = {
          prompt = "Title",
          selection = "Visual",
          header = "WarningMsg", -- For grep/LSP file headers
        },
      },

      -- Provider Configuration
      providers = {
        files = {
          -- Custom ignored directories for 'Files' picker
          ignored_dirs = { ".git", ".jj", "node_modules", ".cache" },
          -- Custom fd command
          -- find_command = { "fdfind", "-H", "--type", "f", "--color", "never" },
          find_command = function(query)
            local cmd = { "fdfind", "-H", "--type", "f", "--color", "never"}
            if vim.g.refer_show_ignored then
              table.insert(cmd, "-u") -- stop ignore
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
