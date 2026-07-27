return {
  "bassamsdata/namu.nvim",
  opts = {
    global = { },
    namu_symbols = { -- Specific Module options
      options = {
        movement = {
          next = { "<C-j>", "<DOWN>" },
          previous = { "<C-k>", "<UP>" }
        }
      },
    },
  },
  keys = {
    {
      "<C-s>", function() require("namu.namu_symbols").show() end, desc="[S]ymbols(LSP)"
    }
  }
}
