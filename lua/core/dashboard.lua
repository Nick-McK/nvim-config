function create_dash()
	vim.cmd[[silent! %bwipeout!]]

	vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(0,0,-1, false, {
		"Welcome to Neovim!",
		"",
		"1. Open a file using :e <filename>",
		"2. Suck my dick"
	})

	vim.api.nvim_buf_set_option(0, "buftype", "nofile")
	vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

	vim.api.nvim_open_win(0, true, {
		relative = "editor",
		width = 30,
		height = 60,
		row = 2,
		col = 2,
		style = "minimal",
		border = "rounded",
	})
end
vim.cmd([[autocmd VimEnter * lua create_dash()]])
