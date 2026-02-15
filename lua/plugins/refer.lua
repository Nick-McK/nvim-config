return {
  "juniorsundar/refer.nvim",
  dependencies = {
    -- Optional: specific fuzzy libs if you want to override defaults
    -- "nvim-mini/mini.fuzzy",
  },
  config = function()
    require("refer").setup({
      -- General Settings
      max_height_percent = 0.4,-- Window height as a percentage of editor height
      min_height = 1,         -- Minimum window height in lines

      -- Async Settings
      debounce_ms = 10,      -- Delay for async searching (files/grep)
      min_query_len = 2,      -- Minimum characters to start async search

      -- Sorting
      available_sorters = { "blink", "mini", "native", "lua" },
      default_sorter = "blink", -- Default sorter for static lists.
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
          find_command = { "fdfind", "-H", "--type", "f", "--color", "never" },
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

      },
    })
  end
}
