local utils = require("core.utils")
return {
  'stevearc/aerial.nvim',
  opts = {
    layout = {
      filter_kind = false
      -- filter_kind = {
      --   "Class",
      --   "Constructor",
      --   "Enum",
      --   "Function",
      --   "Interface",
      --   "Module",
      --   "Method",
      --   "Struct",
      -- }
    }
  },
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
  -- config = function()
  --   vim.api.nvim_create_autocmd({"FileType"}, {
  --     pattern = "aerial",
  --     callback = function(ev)
  --       vim.keymap.set("n", "<M-j>", )
  --     end
  --   })
  -- end
  keys = {
    { "<leader>at", "<cmd>AerialToggle!<cr>", desc="[A]erial [T]oggle" },
    -- {
    --   "<A-j>",
    --   function()
    --     if not utils.is_window_open("qf") and
    --       utils.is_window_open("aerial")
    --     then
    --       vim.cmd("AerialNext")
    --     end
    --   end,
    --   desc="Aerial Next"
    -- },
    -- {
    --   "<A-k>",
    --   function()
    --     if not utils.is_window_open("qf")
    --       and utils.is_window_open("aerial")
    --     then
    --       vim.cmd("AerialPrev")
    --     end
    --   end,
    --   desc="Aerial Next"
    -- }
  }
}
