local M = {}

M.general = {
	n = {
		[";"] = { ":", "Open Command Mode" },
		["<C-b>"] = { "^", "Move to Beginning of Line" },
		["<C-e>"] = {"$", "Move to End of Line"},

		-- Telescope
		["<leader>ff"] = {"<CMD>:Telescope find_files<CR>", "Find Files"},
		["<leader>ft"] = {"<CMD>:Ex<CR>", "Opens File Tree"},
        
        -- Open terminal
        ["<leader>ht"] = {"<CMD>:term<CR>", "Opens Horizontal Terminal"},

        -- Switch windows
        ["<C-j>"] = {"<C-w>j", "Move Down a Window"},
        ["<C-k>"] = {"<C-w>k", "Move Up a Window"}, -- currently doesn't work as there is an overlapping keybind
        ["<C-h>"] = {"<C-w>h", "Move Left a Window"},
        ["<C-l>"] = {"<C-w>l", "Move Right a Window"},

		-- toggle comment
	--	["<leader>o"] = {
	--		function()
	--			local api = require("Comment.api")
	--			--api.call("toggle.linewise", "g@")
	--			api.call('toggle.linewise', 'g@')
	--		end,
	--		"Toggle Comment"},

		-- Jump to context
		["<leader>gcc"] = {
			function()
				require('treesitter-context').go_to_context()
			end, "Jumps to Current Context"},
	},
	-- terminal mode (used for interacting with the terminal ie inserting)
	t = {
		["<C-x>"] = {[[<C-\><C-n>]], "Exit Terminal Mode"},
	}

}

M.term = {
	i = {
		["<C-n>"] = {"<C-\\><C-n>", "Enter Terminal Normal Mode"},
	}
}

return M
