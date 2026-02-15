return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 200
	end,
  opts = {
    preset = "helix" -- smaller right side window
  },
  keys = {
    {
      "<leader>?",
      function()
        require("whch-key").show({ global = false })
      end, desc = "Which Key Local"
    }
  }
}
