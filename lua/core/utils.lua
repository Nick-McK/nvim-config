local M = {}

M.load_config = function()
	local config = require("plugins.init.lua")

	return config
end

-- Loop through all the mappings in the mappings file and set them as keymaps
M.load_mappings = function()
	local mappings = require("core.mappings")
	for mode, modeValues in pairs(mappings.general) do
		for set_bind, command in pairs(modeValues) do
			-- DEBUGGING
			--print("In mode", mode)
			--print("setting bind", set_bind)
			--print("with command", command[1])
			--print("with command", command[2])
			if command[2] == "Toggle Comment" then
				--print("com", command[2])
				vim.keymap.set(mode, set_bind, command[1], {expr=true})
			else
				vim.keymap.set(mode, set_bind, command[1])
			end
		end
	end
end

M.load_mappings()
return M

