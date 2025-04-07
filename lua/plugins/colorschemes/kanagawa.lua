return {
	"rebelot/kanagawa.nvim",
	config = function()
    require("kanagawa").setup({
      transparent = false
    })
    vim.api.nvim_set_hl(0, "Normal", {bg="#111111"})
    vim.api.nvim_set_hl(0, "NormalNC", {bg="#111111"})
    vim.api.nvim_set_hl(0, "EndOfBuffer", {bg="#111111"})
  end
}
