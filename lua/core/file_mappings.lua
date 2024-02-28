-- Add a mapping in cpp and header files to swap between source and header
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.cpp", "*.h"},
	callback = function(ev)
		vim.keymap.set("n", "gh", function()
			-- Swap between header and source file
			local file_name = vim.fn.expand("%:t") -- gets the tail of the current filepath
			local _current_file_path = vim.fn.expand("%:p:h") -- get the absolute path and then remove the file name
			local new_file_name
			-- Replace the file extension with the opposite extension
			if vim.fn.expand("%:e") == "h" then
				new_file_name = string.gsub(file_name, ".h", ".cpp", 1)
			elseif vim.fn.expand("%:e") == "cpp" then
				new_file_name = string.gsub(file_name, ".cpp", ".h", 1)
			end
			local new_file = _current_file_path .. "/" .. new_file_name
			if vim.fn.filereadable(new_file) == 1 then
				vim.api.nvim_command("edit " .. new_file)
			else 
				print("File " .. new_file.. " not readable")
			end

		end)
	end
})
