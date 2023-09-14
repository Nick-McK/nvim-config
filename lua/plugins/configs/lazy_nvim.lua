local opts = {
  defaults = { lazy = false },
  install = {
	missing = true,
	colorscheme = {"tokyonight"},
  },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

}

return opts
