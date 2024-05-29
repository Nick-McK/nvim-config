-- some aliases
local opt = vim.opt
local g = vim.g

g.mapleader = " "
opt.cursorline = false

local mappings = require("core.mappings")
local file_mappings = require("core.file_mappings")
local utils = require("core.utils")
require"core.globals"
-- load mappings
utils.load_mappings(mappings)

-- line numbering
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true

-- indenting
opt.expandtab = true
opt.shiftwidth = 4 -- this is the actual indenting size
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.cursorline = true
opt.colorcolumn = ""

-- Keep 8 lines as a buffer when scrolling
opt.scrolloff = 8

-- disable netrw
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- disable vim startup - this might not be needed, as long as we don't print anything
-- just leave printing and info to the dashboard on startup
-- opt.shortmess = "ltToOCF"
-- ← • ♡
opt.listchars ={tab="❮—❯", space="•"}

-- Word wrapping with h and l
-- opt.whichwrap:append "<>[]hl"
vim.cmd [[set termguicolors]]
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
    end})
