local plugins = {
	"nvim-lua/plenary.nvim",
    {
        "tjdevries/colorbuddy.nvim",
    },
    {
		-- "voidekh/kyotonight.vim",
		"rose-pine/neovim",
        -- "marko-cerovac/material.nvim",
        -- "embark-theme/vim",
        -- name="embark",
		lazy=false,
		priority = 1000,
		opts = function()
			return require("plugins.configs.colourscheme.colourscheme")
		end,
		config = function(_, opts)
			-- setup must be called before initialising the colour scheme
			require("rose-pine").setup(opts.rose_pine)
            -- default to rose-pine theme
			vim.cmd[[colorscheme rose-pine]]
		end,
	},
    {
		"folke/tokyonight.nvim",
        opts = function ()
            return require("plugins.configs.colourscheme.colourscheme")
        end,
        config = function(_,opts)
            require("tokyonight").setup(opts.tokyonight)
        end,
    },
    {
		"catppuccin/nvim",
        lazy=false,
		priority = 1000,
		opts = function()
			return require("plugins.configs.colourscheme.colourscheme")
		end,
		config = function(_, opts)
			-- setup must be called before initialising the colour scheme
			require("catppuccin").setup(opts.catppuccin)
		end,
    },
    {
		"rebelot/kanagawa.nvim",
        lazy=false,
		priority = 1000,
		opts = function()
			return require("plugins.configs.colourscheme.colourscheme")
		end,
		config = function(_, opts)
			-- setup must be called before initialising the colour scheme
			require("kanagawa").setup(opts.kanagawa)
		end,
    },
    {
        "cryptomilk/nightcity.nvim",
        opts = function ()
            return require("plugins.configs.colourscheme.colourscheme")
        end,
        config=function(_, opts)
            require("nightcity").setup(opts.nightcity)
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
        "nvim-tree/nvim-tree.lua",
        opts = function ()
            return require("plugins.configs.nvim_tree")
        end,
        config = function (_, opts)
            require("nvim-tree").setup(opts)
        end
    },
    {
        "nvim-tree/nvim-web-devicons",
        config = function ()
            require("nvim-web-devicons").setup({})
        end
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
				"hrsh7th/cmp-path",
                "onsails/lspkind.nvim", -- cmp icons and sources
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
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {},
            disable_filetype= { "TelescopePrompt", "vim" },
        },
        config = function(_,opts)
            require("nvim-autopairs").setup(opts)

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
    -- Bufferline
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = function ()
            return require("plugins.configs.bufferline")
        end,
        config = function(_, opts)
            require("bufferline").setup(opts)
        end,
    },
    -- TODO: highlighting
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = function ()
            return require "plugins.configs.todo_comments"
        end,
        config = function (_, opts)
            require "todo-comments".setup(opts)
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function ()
            require("which-key").setup({})
        end
    },
    {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.3',
        config = function()
            require('distant'):setup()
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        config=function ()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function ()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function ()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function ()
                dapui.close()
            end
        end

    },
    {
        "mfussenegger/nvim-dap-python",
        ft="python",
        dependencies = {
            "mfussenegger/nvim-dap",-- python adapter plugin
            "rcarriga/nvim-dap-ui" -- dap ui
        },
        config=function (_,opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end

    },
    -- {
    --     dir = "~/dev/neovim/plugins/colour_picker.nvim",
    --     opts = function (_, opts)
    --         -- return require("")
    --     end,
    --     config = function()
    --         require("colour_picker")
    --     end,
    -- },
    -- {
    --     dir="~/dev/neovim/plugins/terminal.nvim/",
    --     config=function ()
    --         require("terminal")
    --     end
    -- },
    -- {
    --     dir="~/dev/neovim/plugins/mycolour/",
    --     config=function ()
    --         -- print(require("colorbuddy").colorscheme("mycolour"))
    --         -- return require("colorbuddy").colorscheme("mycolour")
    --     end
    -- },
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         -- add any options here
    --     },
    --     dependencies = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --         -- OPTIONAL:
    --         --   `nvim-notify` is only needed, if you want to use the notification view.
    --         --   If not available, we use `mini` as the fallback
    --         -- "rcarriga/nvim-notify",
    --     }
    -- }

}

local config = require("plugins.configs.lazy_nvim")


-- plugins is our object containing plugins
require("lazy").setup(plugins, config)
