local M = {}
-- TODO: Sort all these out and format them in some way
M.general = {
    n = {
        ["<leader>sl"] = {"<cmd>set list<cr>", desc="Sets char list"},
        ["<leader>sln"] = {"<cmd>set nolist<cr>", desc="Unsets char list"},
        -- remove trailing whitespace
        -- ["<C-q>"] = { ":qa!<CR>", desc="Force quite all no saving" },
        ["<C-u>"] = {"<C-u>zz", desc="Half page up"},
        ["<C-d>"] = {"<C-d>zz", desc="Half page down"},

        -- Use shift-j for mark prefix (lower case is for same file, upper case across files)
        ["<S-j>"] = {"'"},
        -- Toggle color column option
        ["<leader>tcc"] = {
            function()
                local value = vim.api.nvim_get_option_value("colorcolumn", {})
                if value ~= "" then
                    vim.api.nvim_set_option_value("colorcolumn", "", {})
                else
                    vim.api.nvim_set_option_value("colorcolumn", "110", {})
                end
            end,
            desc = "Toggle Colour Column"
        },

        -- Switch windows
        ["<C-j>"] = { "<C-w>j", desc="Move Down a Window" },
        ["<C-k>"] = { "<C-w>k", desc="Move Up a Window" }, -- currently doesn't work as there is an overlapping keybind
        ["<C-h>"] = { "<C-w>h", desc="Move Left a Window" },
        ["<C-l>"] = { "<C-w>l", desc="Move Right a Window" },
        -- Window splits
        ["<leader>hw"] = { "<CMD>split | wincmd j<CR>", desc="New Horizontal Window" },
        ["<leader>vw"] = { "<CMD>vsp | wincmd l<CR>", desc="New Vertical Window" },
        ["<leader>ht"] = { "<CMD>split | wincmd j | term<CR>", desc="New Horizontal Terminal" },
        ["<leader>vt"] = { "<CMD>vsp | wincmd l | term<CR>", desc="New Vertical Terminal" },

        -- resize splits better
        ["<A-H>"] = { "<CMD>wincmd 2 <<CR>"},
        ["<A-J>"] = { "<CMD>wincmd 2 -<CR>"},
        ["<A-K>"] = { "<CMD>wincmd 2 +<CR>"},
        ["<A-L>"] = { "<CMD>wincmd 2 ><CR>"},

        -- Move lines up and down
        ["<A-j>"] = {"<CMD>m .+1<CR>",desc="Move line up"},
        ["<A-k>"] = {"<CMD>m .-2<CR>",desc="Move line up"},

        ["<leader>ve"] = {
            function()
                vim.diagnostic.open_float({border = "rounded"})
            end, desc="Inspect Error Message"
        },

        -- ["<C-n>"] = { ":lua require('oil').toggle_float()<CR>", desc="Toggle Nvim Tree" },
        ["<C-n>"] = { "<cmd>Oil<cr>", desc="Toggle Nvim Tree" },
        ["<leader>e"] = { ":NvimTreeFocus<CR>", desc="Focus Nvim Tree" },
        --
        ------ TODO COMMENTS ------
        ["td"] = { ":TodoQuickFix<CR>", desc="Open Quick Fix for ToDo" },
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
        ["<leader>fH"] = {":Telescope help_tags<CR>", desc="Find Help Page"},
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
        ["<leader><leader>"] = {"<CMD>Telescope buffers theme=ivy<CR>", desc="Search Open Buffers"},

	},
}


M.lspconfig = {
	n = {
		["<leader>li"] = { "<CMD>LspInfo<CR>", desc = "LSP Info" },
		["<leader>lr"] = { "<CMD>LspRestart<CR>", desc = "LSP Restart" },
    },
}

return M
