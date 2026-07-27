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
  keys = {
    {
      "<leader>td", function() Snacks.picker.todo_comments() end, desc="[T]o[D]o"
    },
    {
      "<leader>nm", function() Snacks.picker.todo_comments({ keywords = {"NMNM", "TODO", "NMTODO" } }) end, desc="Todo filter=[NM]"
    }
  },
  -- config = function(_, opts)
  --   require "todo-comments".setup(opts)
  -- end,
}
