function create_dash()
	vim.cmd[[silent! %bwipeout!]]
	local goku = {
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⠙⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⡞⢹⠀⠹⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⣿⠀⠀⣸⣥⣸⠇⠀⠙⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⡇⠀⣴⡟⢸⢻⣀⢾⡿⣿⡿⠀⡀⠀⣞⢆⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡹⢇⣼⡿⠁⣼⡼⢣⡿⢁⢿⡇⢠⡇⠀⢹⡘⡆⢰⣿⠀⠀⠀⠀⣼⡇⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⠀⠀⣸⠏⡇⢸⣿⠇⠀⡼⣯⡿⠁⢸⠀⡇⣾⠀⠀⠀⣿⢹⡞⢹⣇⠀⣠⢾⣿⡇⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⣸⢏⢧⢀⣿⢠⡇⢺⣿⠀⣸⢡⡿⣁⠀⡘⠀⡇⣿⠀⠀⠀⡏⣾⡇⢸⠸⡞⣍⣿⢹⡇⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⢰⣆⠀⠀⢠⣿⢸⠘⣾⣏⢸⢧⠸⣽⡤⣷⡟⢠⡇⠀⡇⢠⣽⡿⠀⠀⠀⣹⣿⠁⢸⠀⠹⣿⠇⡌⡇⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⢾⣿⢧⡀⣼⡇⠘⡄⢹⣿⣼⠸⠀⢳⣻⡟⠀⡾⠁⠀⡇⠀⣿⡄⠀⢀⣾⡿⢃⡄⢸⠀⠀⢏⣰⡅⢹⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠘⣧⢻⢿⣿⠀⠀⢹⡀⢻⣻⠀⠃⠈⢿⡗⢠⣿⠀⠰⠇⠀⢸⢧⣴⣿⠋⢡⣿⠀⣼⠀⠀⠸⣇⠇⣸⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠹⡄⢰⠛⡇⠀⠀⢣⠘⡷⡇⠀⠀⢸⣿⣿⣳⠀⠀⠀⠀⠸⣼⣷⠣⣀⡾⠋⢀⠘⠀⠀⠀⡟⢀⣼⠀⠀⠀⠀⢀⣠",
		"⢠⣄⠀⠀⠀⢱⣸⠀⡇⢠⠀⠀⠃⠹⡝⣄⠀⢸⣿⣿⡫⠀⠀⠀⠀⣸⣿⢧⣾⠏⠀⢁⡎⠀⠀⠀⢠⣇⡞⡞⣀⢤⣴⣾⢽⡟",
		"⠈⣿⣷⢄⡀⠈⢿⢸⣧⠈⢧⠀⠀⠀⠹⣎⠳⣼⣿⣏⣯⡆⠀⠀⢀⣿⣿⣿⠃⠀⠀⣼⠀⠀⡴⢠⣿⡟⣺⡯⠟⣩⠜⢁⡜⠀",
		"⠀⢸⡌⢢⣈⠒⢼⣾⣇⢳⡈⢧⠀⠀⠀⠙⢷⣼⣿⣿⠟⠓⣠⣶⣻⠞⠋⠙⡆⠀⣀⡇⠀⢰⠁⣾⠟⡰⠁⣠⠞⣁⠞⡽⠀⠀",
		"⠀⠀⢷⡝⣍⠳⣄⠸⣿⡀⢷⡈⢣⣠⣤⣤⣾⡿⠋⢁⣶⣶⣿⠋⢀⡤⠤⣀⣿⣏⡁⢻⣦⠃⡼⣼⡜⠁⠚⢁⡴⢁⡜⠁⠀⠀",
		"⠀⠀⠈⣿⣌⠣⡈⡑⢿⣧⡀⣷⣿⠟⢉⡿⠋⢀⡴⢉⡾⠁⣀⣴⠿⢀⣤⣼⣿⣿⡄⠘⣿⢷⢱⠟⢀⢴⡿⠋⣠⠎⠀⠀⠀⠀",
		"⠀⠀⠀⠘⣿⣶⡌⠪⡢⣻⣿⣿⠃⠀⣾⠁⠰⠊⢠⣾⡟⢉⠽⠋⡰⠛⠙⠻⣿⣿⡇⠀⢸⣸⡝⣾⠝⣡⣼⠟⠁⢀⣀⠀⠀⠀",
		"⠀⠀⠀⠀⠈⠻⣝⢦⣌⣻⣿⠁⠀⣾⡏⢠⠃⡴⣻⡿⡰⠃⣠⠞⠀⠀⠀⠀⢹⡟⠃⢀⣎⣏⢇⢸⣮⣿⢥⣴⣾⡿⠃⠀⠀⠀",
		"⠀⠀⠀⠀⠀⢤⣌⣓⣿⣿⣿⡀⢸⣿⡇⣸⡿⠀⢸⡿⢁⡔⠋⠀⠀⠀⢀⡠⢾⣧⣆⢎⣾⣿⣿⣿⣀⣬⠝⡿⠋⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠻⡳⣢⣽⣿⣿⢿⣿⣷⣿⡓⢦⣸⣷⠺⡄⠀⠀⡠⠞⠁⣠⣼⣿⣿⣿⣿⣽⣯⡿⣽⣮⠟⠁⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠈⠪⣙⢿⢹⣿⣿⣿⣟⠉⢳⣿⣧⣄⣸⡶⣎⣠⣶⣽⡾⠟⣫⠻⢿⣿⢀⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⣳⣝⣿⣟⠻⠭⠭⠵⠶⠯⠟⡛⠛⡛⢒⣒⣉⡉⠁⢠⢟⣿⠾⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠿⣿⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⢀⣾⡛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⢯⡱⡄⠀⠀⠀⢛⣦⣆⡀⠀⠀⠀⠀⡞⠈⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⡞⠀⢨⢿⣾⣄⠀⠀⠹⣶⠶⠁⠀⢀⣴⢯⠀⠈⡗⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⣠⣤⣤⠴⠋⢁⡠⡇⠀⠈⣦⠳⡌⣷⢤⡀⠀⠀⣠⠖⣩⣳⠃⠀⠀⡇⠀⠈⠢⣤⣤⢤⡀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠞⢹⠛⠁⣠⠞⣁⣤⠇⠀⠀⣟⢇⠙⣍⠙⣎⠩⠍⠁⡴⣱⠃⠀⠀⠀⠿⣄⠀⡀⠈⣿⠃⠃⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠈⢷⣎⣠⠛⢁⣀⡤⠤⠴⠧⢼⣆⣈⢣⡘⠆⣠⠞⢰⠃⣀⣀⣀⣀⡀⠈⠳⢅⣶⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠈⢦⣞⣉⣁⣀⣀⣀⡤⠤⠀⠀⠈⠉⠛⢺⡷⠒⣉⣉⣀⣀⠀⠀⠈⠉⣹⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⡋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⡀⠀⠈⠛⠓⡦⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠑⠒⠢⠬⠤⠤⠤⠤⠤⠤⠼⠭⠤⠤⠅⠒⠒⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"					       ",
		"To Start:				       ",
		"1. <leader>ff - Find File		       ",
		"2. <leader>ft - File Tree		       ",
		"					       ",
		"					       ",
		"					       ",}
	-- declare variables
	local centered_goku = {}
	local max_length = 0
	local width = vim.fn.winwidth(0)
	-- get max line length
	for _, line in ipairs(goku) do
		local line_width = vim.fn.strwidth(line)
		max_length = math.max(max_length, line_width)
	end
	-- clear buffers
	vim.fn.setline(1, {})
	-- determine padding for the image
	local padding = math.floor((width - max_length) / 2)
	-- add the padding for each line in the table
	for _, line in ipairs(goku) do
		local centered_line = string.rep(" ", padding)..line
		-- insert the centered lines to a new table
		table.insert(centered_goku, centered_line)
	end
	-- append the centered table to the main buffer
	vim.fn.append(0, centered_goku)

--	vim.api.nvim_create_buf(false, true)
--	vim.api.nvim_buf_set_lines(0,0,-1, false, centered_goku)
    vim.api.nvim_buf_set_option(0, "modifiable", false)
	vim.api.nvim_buf_set_option(0, "buftype", "nofile")
	vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")
	-- buffer, 
	--vim.api.nvim_open_win(0, true, {
	--	relative = "editor",
	--	width = max_length + padding * 2,
	--	height = #goku,
	--	row = math.floor((vim.fn.winheight(0) - #goku) / 2),
	--	col = padding,
	--	style = "minimal",
	--	border = "rounded",
	--})
end
vim.cmd([[autocmd VimEnter * lua create_dash()]])
