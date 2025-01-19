local functions = require("core.functions")
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

vim.api.nvim_create_autocmd({"TextChangedI"}, {
    callback=function()
        functions.toggle_custom_color_col()
    end
})
vim.api.nvim_create_autocmd({"TextChanged"}, {
    callback=function()
        functions.toggle_custom_color_col()
    end
})

-- remove whitespace
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    callback=function()
        vim.cmd[[%s/\s\+$//e]]
    end
})

-- highlight text that was yanked
vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.highlight.on_yank({higroup="Visual", timeout=300})
    end
})

-- Open help in vertical split on the right instead of in horizontal split above
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern="*.txt",
    callback = function()
        if vim.bo.filetype == "help" then
            vim.cmd.wincmd("L")
        end
    end
})

