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
    dev = {
        path = "~/dev/neovim/plugins/",
    },

}

return opts
