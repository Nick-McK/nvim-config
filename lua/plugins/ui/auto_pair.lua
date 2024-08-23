return {
	"windwp/nvim-autopairs",
	event="InsertEnter", -- Load only when we enter insert mode
	config = true -- config = true is the equivalent to using a function require("..").setup({})
}
