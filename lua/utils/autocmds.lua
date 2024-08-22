vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 0
		vim.cmd('startinsert')
	end
})
-- always go into insert mode on terminal enter
vim.api.nvim_create_autocmd({"BufEnter"}, {
    callback=function()
        if vim.bo.buftype == "terminal" then
            vim.cmd('startinsert')
        end
    end
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    callback=function()
        vim.cmd[[%s/\s\+$//e]]
    end
})

