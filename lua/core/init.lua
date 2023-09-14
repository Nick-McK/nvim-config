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

-- disable vim startup - this might not be needed, as long as we don't print anything
-- just leave printing and info to the dashboard on startup
--opt.shortmess:append("I")


-- Word wrapping with h and l
opt.whichwrap:append "<>[]hl"
