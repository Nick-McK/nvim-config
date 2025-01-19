local functions = require("core.functions")

local M = {}
-- TODO: Sort all these out and format them in some way
M.general = {
    n = {
        ["<leader>x"] = {"<cmd>source %<cr>", desc="source current file"},

        ["<leader>sl"] = {"<cmd>set list<cr>", desc="Sets char list"},
        ["<leader>sln"] = {"<cmd>set nolist<cr>", desc="Unsets char list"},
        -- navigation prettier
        ["<C-u>"] = {"<C-u>zz", desc="Half page up"},
        ["<C-d>"] = {"<C-d>zz", desc="Half page down"},

        -- Use shift-j for mark prefix (lower case is for same file, upper case across files)
        -- ["<S-j>"] = {"'"},
        -- Toggle color column option
        ["<A-t>"] = {
            function()
                local value = vim.api.nvim_get_option_value("colorcolumn", {})
                if value ~= "" then
                    vim.api.nvim_set_option_value("colorcolumn", "", {})
                    -- too lazy to set highlight properly so i will just change
                    -- this based on colourscheme :)
                    vim.api.nvim_set_hl(0, "ColorColumn", {bg="#222222"})
                else
                    vim.api.nvim_set_option_value("colorcolumn", "80", {})
                    vim.api.nvim_set_hl(0, "ColorColumn", {bg="#222222"})
                end
            end,
            desc = "Toggle Colour Column"
        },

        -- ["H"] = {"<cmd>prev<cr>", desc="previous arg list file"},
        -- ["L"] = {"<cmd>next<cr>", desc="previous arg list file"},

        -- Switch windows
        ["<C-j>"] = { "<C-w>j", desc="Move Down a Window" },
        ["<C-k>"] = { "<C-w>k", desc="Move Up a Window" },
        ["<C-h>"] = { "<C-w>h", desc="Move Left a Window" },
        ["<C-l>"] = { "<C-w>l", desc="Move Right a Window" },
                                                                -- Window splits
        ["<leader>hw"] = { "<CMD>split | wincmd j<CR>", desc="New Horizontal Window" },
        ["<leader>vw"] = { "<CMD>vsp | wincmd l<CR>", desc="New Vertical Window" },
        -- Terminals
        ["<A-s>"] = { "<CMD>belowright 15split | wincmd j | term<CR>", desc="New Horizontal Terminal" },
        ["<A-v>"] = { "<CMD>100vsp | wincmd l | term<CR>", desc="New Vertical Terminal" },

        -- resize splits better
        ["<A-H>"] = { "<CMD>wincmd 2 <<CR>"},
        ["<A-J>"] = { "<CMD>wincmd 2 -<CR>"},
        ["<A-K>"] = { "<CMD>wincmd 2 +<CR>"},
        ["<A-L>"] = { "<CMD>wincmd 2 ><CR>"},

        -- Old - keeping for the cmd
        -- ["<A-k>"] = {"<CMD>m .-2<CR>",desc="Move line up"},
        -- ["<A-j>"] = {"<CMD>m .+1<CR>",desc="Move line up"},
        ["<A-j>"] = {"<cmd>cnext<cr>", desc="Next Quickfix"},
        ["<A-k>"] = {"<cmd>cprev<cr>", desc="Previous Quickfix"},

        ["<leader>ve"] = {
            function()
                vim.diagnostic.open_float({border = "rounded"})
            end, desc="Inspect Error Message"
        },

        -- ["<C-n>"] = { ":lua require('oil').toggle_float()<CR>", desc="Toggle Nvim Tree" },
        ["<C-n>"] = { "<cmd>Oil<cr>", desc="Toggle Nvim Tree" },
        --
        ------ TODO COMMENTS ------
        ["td"] = { ":TodoQuickFix<CR>", desc="Open Quick Fix for ToDo" },

        ["<C-t>"] = {function()
            if functions.state.cc == false then
                functions.toggle_custom_color_col()
            else
                functions.clear_custom_color_col()
            end
        end, desc="testing"},

        -- Inspect messages - this will need to be changed if Noice is uninstalled back to messages
        ["<leader>im"] = {"<cmd>Noice | wincmd L<cr>", desc="[I]nspect [M]essages"},


        -- Set the current window to appear on the right
        ["<leader>wl"] = {"<cmd>wincmd L<cr>", desc="Move window right"},
        ["<leader>wh"] = {"<cmd>wincmd H<cr>", desc="Move window left"},
    },

    -- INSERT MODE
    i = {
        ["<C-h>"] = { "<LEFT>", desc="Move Left in Insert Mode" },
        ["<C-j>"] = { "<DOWN>", desc="Move Down in Insert Mode" },
        ["<C-k>"] = { "<UP>", desc="Move Up in Insert Mode" },
        ["<C-l>"] = { "<RIGHT>", desc="Move Right in Insert Mode" },
    },
    -- terminal mode (used for interacting with the terminal ie inserting)
    t = {
        ["<C-x>"] = { [[<C-\><C-n>]], desc="Exit Terminal Mode" },
        -- Add window move commands in terminal
        ["<C-h>"] = {"<cmd>wincmd h<cr>", desc="Move window left"},
        ["<C-l>"] = {"<cmd>wincmd l<cr>", desc="Move window right"},
        ["<C-j>"] = {"<cmd>wincmd j<cr>", desc="Move window down"},
        ["<C-k>"] = {"<cmd>wincmd k<cr>", desc="Move window up"},

        -- Resize windows
        ["<A-H>"] = { "<CMD>wincmd 2 <<CR>"},
        ["<A-J>"] = { "<CMD>wincmd 2 -<CR>"},
        ["<A-K>"] = { "<CMD>wincmd 2 +<CR>"},
        ["<A-L>"] = { "<CMD>wincmd 2 ><CR>"},
    },
}

M.telescope = {
    n = {
        -- ["<leader>ff"] = { ":Telescope find_files<CR>", desc="Find File" },
        ["<leader>ff"] = { function()
            local no_preview_drop_down = require("plugins.ui.telescope").no_preview
            return require("telescope.builtin").find_files(no_preview_drop_down)
        end, desc="Find File" },

        ["<leader>sf"] = { ":Telescope lsp_document_symbols symbols=function<CR>", desc="Search Functions in CurBuf" },
        ["<leader>fw"] = {function ()
            require("telescope.builtin").grep_string({word_match="-w", cwd=vim.loop.cwd()})
        end, desc="Find Word (root)"},
        ["<leader>fM"] = {":Telescope man_pages<CR>", desc="Find Man Page"},
        ["<leader>fH"] = {"<cmd>Telescope help_tags<cr>", desc="Find Help Page"},
        ["<leader>fb"] = {":Telescope current_buffer_fuzzy_find<CR>", desc="Search Buffer"},
        ["<leader>fd"] = {":Telescope diagnostics bufnr=0<CR>", desc="Current Buffer Diagnostics"},
        ["<leader>fD"] = {":Telescope diagnostics<CR>", desc="Workspace Diagnostics"},
        ["<leader>fg"] = {":Telescope live_grep<CR>", desc="Grep (root)"},
        ["<leader>;"] = {":Telescope command_history<CR>", desc="Grep (root)"},
        ["<leader>fs"] = {
            function()
                require("telescope.builtin").lsp_document_symbols({
                    symbols = require("utils.symbols").symbols
                })
            end, desc="Find Symbols in Buffer"
        },

        ["<leader>ft"] = {
            function ()
                require("telescope.builtin").colorscheme({enable_preview=true})
            end, desc="Find Colour Schemes"
        },
        ["<C-e>"] = {"<CMD>Telescope buffers<CR>", desc="Search Open Buffers"},

        ["<A-m>"] = {"<CMD>Telescope marks<CR>", desc="Search Open Buffers"},
        ["<leader>fp"] = {function() require("telescope.builtin").find_files({
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            })
        end}


	},
}

M.neotree = {
    n = {
        ["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc="NeoTree"},
    }
}


M.lspconfig = {
	n = {
		["<leader>li"] = { "<CMD>LspInfo<CR>", desc = "LSP Info" },
		["<leader>lr"] = { "<CMD>LspRestart<CR>", desc = "LSP Restart" },
    },
}

-- This only works because now loading all mappings after lazy has loaded all plugins
local harpoon = require("harpoon")
M.harpoon = {
    n = {
        ["<A-h>"] = {function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc="[H]arpoon [L]ist"},
        ["<leader>a"] = {function() harpoon:list():add() end, desc="[H]arpoon [A]dd"},
        ["<A-1>"] = {function() harpoon:list():select(1) end, desc="Harpoon Item 1"},
        ["<A-2>"] = {function() harpoon:list():select(2) end , desc="Harpoon Item 2"},
        ["<A-3>"] = {function() harpoon:list():select(3) end , desc="Harpoon Item 2"},
        ["<A-4>"] = {function() harpoon:list():select(4) end , desc="Harpoon Item 2"},
        ["<A-5>"] = {function() harpoon:list():select(5) end , desc="Harpoon Item 2"},
    },
}

return M
