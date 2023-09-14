local M = {}

M.general = {
	n = {
		[";"] = { ":", "Open Command Mode" },
		["<C-b>"] = { "^", "Move to Beginning of Line" },
		["<C-e>"] = {"$", "Move to End of Line"},
	}
}

return M
