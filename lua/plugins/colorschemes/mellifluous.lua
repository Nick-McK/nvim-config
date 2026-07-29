return {
  "ramojus/mellifluous.nvim",
  opts = {
    colorsets = "alduin",
    transparent_background = {
      enabled = true
    }
  },
  lazy = false,
  priority = 1000,
  -- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
  config = function()
    -- vim.cmd("colorscheme mellifluous")
  end,
}
