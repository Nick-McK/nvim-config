-- some aliases
local opt = vim.opt
local g = vim.g

g.mapleader = " "
opt.cursorline = false

local mappings = require("core.mappings")
local utils = require("core.utils")
require"core.globals"
require"utils.autocmds"
-- load mappings
utils.load_mappings(mappings)

-- line numbering
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true


-- indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.autoindent = false
opt.smartindent = true

opt.cursorline = true


-- disable netrw in favour of nvim tree
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- ← • ♡
opt.listchars = { tab="❮—❯", space="•" }

vim.cmd [[set termguicolors]]
