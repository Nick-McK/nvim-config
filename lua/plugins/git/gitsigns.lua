return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end,
  keys = {
    {
      "<leader>glh",
      function()
        require("gitsigns").toggle_numhl(true)
      end,
      desc="[G]it [L]ine [H]ighlight"
    },
    {
      "<leader>gsh",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc="[G]it [S]tage [H]unk"
    },
    {
      "]h",
      function()
        require("gitsigns").nav_hunk("next")
      end,
      desc="Next Hunk"
    },
    {
      "[h",
      function()
        require("gitsigns").nav_hunk("prev")
      end,
      desc="Prev Hunk"
    }
  }
}
