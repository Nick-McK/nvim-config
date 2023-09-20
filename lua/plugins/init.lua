local plugins = {
	"nvim-lua/plenary.nvim",
	{
		-- "folke/tokyonight.nvim",
		-- "catppuccin/nvim",
		-- "voidekh/kyotonight.vim",
		-- "rebelot/kanagawa.nvim",
		"rose-pine/neovim",
		lazy=false,
		priority = 1000,
		opts = function()
			return require("plugins.configs.colourscheme")
		end,
		config = function(_, opts)
			-- setup must be called before initialising the colour scheme
			require("rose-pine").setup(opts)
			vim.cmd[[colorscheme rose-pine]]
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function()
			return require("plugins.configs.mason")
		end,
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
		end
	},
	{
		"nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
		opts = function()
			return require("plugins.configs.telescope")
		end,
        config = function(_, opts)
            require("telescope").setup(opts)

        end,

	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function()
			return require("plugins.configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"numToStr/Comment.nvim",
		 opts = function()
		 	return require ("plugins.configs.comment")
		 end,
		 config = function(_, opts)
		 	require("Comment").setup({})
		 end,
		 lazy=false,
	},

	{
		"saadparwaiz1/cmp_luasnip",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_,opts)
					require("luasnip").setup(opts)
				end
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-buffer",
			},

		},
		opts = function()
			return require("plugins.configs.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            return require("plugins.configs.lualine")
        end,
        config = function(_, opts)
            require("lualine").setup(opts)
        end,
    },

}

local config = require("plugins.configs.lazy_nvim")


-- plugins is our object containing plugins
require("lazy").setup(plugins, config)
