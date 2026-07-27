return {
  "FylerOrg/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable",  -- Latest release branch
  opts = {
    win_opts = {
      relativenumber = true
    },
    integrations = {
      icon = "nvim_web_devicons"
    },
    kind_presets = {
      split_left_most = { width = "20%" }
    },
    mappings = {
      n = {
        ["<M-i>"] = {
          action = "toggle_ui",
          args = { "hidden_items" }
        }
      }
    }

  },
  keys = {
    {
      "<leader>e",
      function() require("fyler").open({kind="split_left_most"}) end,
      desc="Fyler"
    }
  }
}
