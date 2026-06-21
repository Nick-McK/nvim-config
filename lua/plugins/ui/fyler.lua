return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",  -- Latest release branch
  config = function()
    require("fyler").setup({
      views = {
        finder = {
          win = {
            kinds = {
              split_left_most = {
                width = "20%",
                win_opts = {winfixwidth = true}
              }
            }
          }
        }
      }
    })
  end,
  keys = {
    {
      "<leader>e",
      function() require("fyler").open({kind="split_left_most"}) end,
      desc="Fyler"
    }
  }
}
