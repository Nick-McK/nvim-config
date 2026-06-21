return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      NMNM = {
        icon = " ",
        color = "error",
        alt = {"NICK", "Nick", "NMNMNM", "NMTODO"}
      }
    },
  },
  config = function(_, opts)
    require "todo-comments".setup(opts)
  end,
}
