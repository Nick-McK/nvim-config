return {
	"rebelot/kanagawa.nvim",
	config = function()
    require("kanagawa").setup({
      compile = false,
      transparent = true,
      colors = {
        theme = {
          dragon = {
            ui = {
              bg_gutter = "none"
            }
          }
        }
      },
    })
    vim.api.nvim_set_hl(0, "Normal", {bg="#111111"})
    vim.api.nvim_set_hl(0, "NormalNC", {bg="#111111"})
    vim.api.nvim_set_hl(0, "EndOfBuffer", {bg="#111111"})

    vim.cmd[[colorscheme kanagawa-dragon]]
  end
}
