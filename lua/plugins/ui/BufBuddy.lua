return {
  dir = "~/dev/plugins/BufBuddy/",
  -- opts = {
  --   use_absolute_paths = true,
  --   buffers_in_tabline = true,
  --   float = {
  --     height = "auto",
  --     width = 110,
  --     title = "Buffers"
  --   },
  --   split = {
  --     width_type = "auto", -- auto or static. auto will keep each file on 1 line. static uses width
  --     width = 10, -- only applies to static width type
  --     direction = "left",
  --     identifier = "―‣" -- string used to indicate which buffer is active
  --
  --   },
  --   mappings = {
  --     -- Opens a floating window showing the list of buffers
  --     open_float = "<C-a>",
  --     -- Opens a split containing the list of buffers
  --     open_split = "<A-e>",
  --     -- Opens a window showing buffers at the cursor. This type has no window opts
  --     -- because the width and height are dependent on the height and length of the
  --     -- contained buffers
  --     open_cursor = ",",
  --
  --     -- Cycle to the next buffer in the list. Wraps around at the start
  --     next = "",
  --     -- Cycle to the previous buffer in the list. Wraps around at the end
  --     prev = "",
  --
  --     float = {
  --       quit = "q",
  --       select = "<CR>"
  --     },
  --     split = {
  --       quit = "q",
  --       select = "<CR>"
  --     },
  --     cursor = {
  --       quit = "q",
  --       select = "<CR>"
  --     }
  --   }
  -- },
  -- keys = {
  --   {
  --     "<Tab>", function() require("BufBuddy"):open_ui("float") end, desc="BufBuddy"
  --   },
  --   {
  --     "]b", function() require("BufBuddy"):next() end, desc="Next Buffer"
  --   },
  --   {
  --     "[b", function() require("BufBuddy"):prev() end, desc="Prev Buffer"
  --   }
  -- }
  config = function()
    ---@class Manager
    local buf_buddy = require("BufBuddy").setup({
      use_absolute_paths = true,
      buffers_in_tabline = true,
      float = {
        height = "auto",
        width = "auto",
        title = "Buffers"
      },
      split = {
        width_type = "auto", -- auto or static. auto will keep each file on 1 line. static uses width
        width = 10, -- only applies to static width type
        direction = "left",
        identifier = "―‣" -- string used to indicate which buffer is active

      },
      mappings = {
        -- Opens a floating window showing the list of buffers
        -- open_float = "<C-a>",
        -- Opens a split containing the list of buffers
        open_split = "<A-e>",
        -- Opens a window showing buffers at the cursor. This type has no window opts
        -- because the width and height are dependent on the height and length of the
        -- contained buffers
        open_cursor = ",",

        -- Cycle to the next buffer in the list. Wraps around at the start
        next = "",
        -- Cycle to the previous buffer in the list. Wraps around at the end
        prev = "",

        float = {
          quit = "q",
          select = "<CR>"
        },
        split = {
          quit = "q",
          select = "<CR>"
        },
        cursor = {
          quit = "q",
          select = "<CR>"
        }
      }

    })
    vim.keymap.set("n", "<TAB>", function()buf_buddy.open_ui("float")end, {desc="BufBuddy"})
    vim.keymap.set("n", "<M-1>", function()buf_buddy.select(1)end, {desc="[BufBuddy] Buffer 1"})
    vim.keymap.set("n", "<M-2>", function()buf_buddy.select(2)end, {desc="[BufBuddy] Buffer 2"})
    vim.keymap.set("n", "<M-3>", function()buf_buddy.select(3)end, {desc="[BufBuddy] Buffer 3"})
    vim.keymap.set("n", "<M-4>", function()buf_buddy.select(4)end, {desc="[BufBuddy] Buffer 4"})
    vim.keymap.set("n", "<m-5>", function()buf_buddy.select(5)end, {desc="[bufbuddy] buffer 5"})
  end
}
