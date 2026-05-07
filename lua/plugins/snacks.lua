return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dim = { enabled = false },
    debug = { enabled = true },
    lazygit = { enabled = true }
  },
  keys = {
        { "<leader>a", function() Snacks.explorer() end, desc = "File Explorer" },
        { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazy Git"}
  }
}
