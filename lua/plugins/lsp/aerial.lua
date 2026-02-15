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
}
