local plugins = {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = function()
			return require("plugins.configs.tokyonight")
		end,
		config = function()
			vim.cmd[[colorscheme tokyonight]]
			require("tokyonight").setup(opts)
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function()
			return require("plugins.configs.mason")
		end,
		config = function()
			require("mason").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
--		opts = function()
--			return require("plugins.configs.lspconfig")
--		end,
--		config = function()
--			require("lspconfig").setup(opts)
--		end
	}
}

local config = require("plugins.configs.lazy_nvim")


-- plugins is our object containing plugins
require("lazy").setup(plugins, config)
