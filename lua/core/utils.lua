local M = {}
	

M.load_config = function()
	local config = require("plugins.init.lua")

	return config
end

-- Loop through all the mappings in the mappings file and set them as keymaps
M.load_mappings = function()
	mappings = require("core.mappings")
	for mode, modeValues in pairs(mappings.general) do
		for set_bind, command in pairs(modeValues) do
			vim.keymap.set(mode, set_bind, command[1])	
		end
	end
end
M.load_mappings()
return M

