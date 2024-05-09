return {
	"williamboman/mason.nvim",
	opts = function()
		return {
			ensure_installed = {
				"pyright",
				"debugpy",
				"bash-language-server",
				"lua-language-server",
				"clangd"
			},
			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "u",
				check_server_version = "c",
				update_all_servers = "U",
				check_outdated_servers = "C",
				uninstall_server = "X",
				cancel_installation = "<C-c>",
			},
		}
	end,
	config = function(opts)
		require("mason").setup(opts)
	end,

}
