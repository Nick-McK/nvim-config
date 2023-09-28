-- some aliases
local opt = vim.opt
local g = vim.g

g.mapleader = " "
opt.cursorline = false

require("core.mappings")
require("core.utils")

-- line numbering
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true


-- indenting
opt.expandtab = true
opt.shiftwidth = 4 -- this is the actual indenting size
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4


-- disable vim startup - this might not be needed, as long as we don't print anything
-- just leave printing and info to the dashboard on startup
--opt.shortmess:append("I")


-- Word wrapping with h and l
opt.whichwrap:append "<>[]hl"
vim.cmd [[set termguicolors]]
