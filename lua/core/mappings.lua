local M = {}
-- TODO: Sort all these out and format them in some way
M.general = {
    n = {
        ["<C-q>"] = { ":qa!<CR>", desc="Force quite all no saving" },
        [";"] = { ":", desc="Open Command Mode" },
        ["<C-b>"] = { "^", desc="Move to Beginning of Line" },
        ["<C-e>"] = { "$", desc="Move to End of Line" },

        -- open theme switcher
        ["<leader>th"] = { function()
            require("colour_picker").open_theme_window()
        end, desc="Opens Theme Switcher Menu" },


        -- Open terminal
        --["<leader>ht"] = {"<CMD>:term<CR>", "Opens Horizontal Terminal"},

        -- Switch windows
        ["<C-j>"] = { "<C-w>j", desc="Move Down a Window" },
        ["<C-k>"] = { "<C-w>k", desc="Move Up a Window" }, -- currently doesn't work as there is an overlapping keybind
        ["<C-h>"] = { "<C-w>h", desc="Move Left a Window" },
        ["<C-l>"] = { "<C-w>l", desc="Move Right a Window" },
        -- Window splits
        ["<leader>wh"] = { "<CMD>split | wincmd j<CR>", desc="New Horizontal Window" },
        ["<leader>wv"] = { "<CMD>vsp | wincmd l<CR>", desc="New Vertical Window" },


        -- open horizontal terminal
        ["<leader>ht"] = {
            function()
                require("terminal").terminal_horizontal()
            end, desc="Opens Horizontal Terminal" },
        ["<leader>vt"] = {
            function()
                require("terminal").terminal_vertical()
            end, desc="Opens Vertical Terminal" },
        -- DEBUG WINDOW
        ["<leader>dw"] = { function()
            local term = require("terminal")
            term.debug()
        end, desc="Terminal debugging" },
        -- opens floating terminal
        -- ["<leader>ft"] = {
        --     function()
        --         local term = require("terminal")
        --         term.open_term()
        --     end, desc="Opens Floating Terminal" },
        -- Hide terminal
        ["<A-h>"] = {
            function()
                local term = require("terminal")
                term.hide_terminals()
            end, desc="Shows Terminals" },

        ["<leader>st"] = { function()
            local term = require("terminal").show_terminal_list()
        end, desc="Shows a list of terminals" },


        -- Show floating terminal
        ["<leader>sft"] = {
            function()
                local term = require("terminal")
                term.show_terminal()
                -- print("wtf is this", term.term_table[1].win)
            end, desc="Shows Terminals" },
        -- Jump to context
        ["<leader>gcc"] = {
            function()
                require('treesitter-context').go_to_context()
            end, desc="Jumps to Current Context" },




        -- PLUGINS
        ------ BUFFERLINE ------
        ["<leader>1"] = { ":BufferLineGoToBuffer 1<CR>", desc="Go To Buffer 1" },
        ["<leader>2"] = { ":BufferLineGoToBuffer 2<CR>", desc="Go To Buffer 2" },
        ["<leader>3"] = { ":BufferLineGoToBuffer 3<CR>", desc="Go To Buffer 3" },
        ["<leader>4"] = { ":BufferLineGoToBuffer 4<CR>", desc="Go To Buffer 4" },
        ["<leader>5"] = { ":BufferLineGoToBuffer 5<CR>", desc="Go To Buffer 5" },
        ["<leader>6"] = { ":BufferLineGoToBuffer 6<CR>", desc="Go To Buffer 6" },
        ["<leader>7"] = { ":BufferLineGoToBuffer 7<CR>", desc="Go To Buffer 7" },
        ["<leader>8"] = { ":BufferLineGoToBuffer 8<CR>", desc="Go To Buffer 8" },
        ["<leader>9"] = { ":BufferLineGoToBuffer 9<CR>", desc="Go To Buffer 9" },

        -- Close Buffer
        ["<leader>x"] = { ":BufferLinePickClose<CR>", desc="Pick a Buffer To Close" },
        -- Cycle Buffers
        ["<tab>"] = { ":BufferLineCycleNext<CR>", desc="Cycle Buffers Right" },
        ["<S-tab>"] = { ":BufferLineCyclePrev<CR>", desc="Cycle Buffers Left" },


        ------ BUFFERLINE END ------
        --
        ------ NVIM TREE ------

        ["<C-n>"] = { ":NvimTreeToggle<CR>", desc="Toggle Nvim Tree" },
        ["<leader>e"] = { ":NvimTreeFocus<CR>", desc="Focus Nvim Tree" },
        ------ NVIM TREE END ------
        --
        --
        ------ TODO COMMENTS ------
        ["td"] = { ":TodoQuickFix<CR>", desc="Open Quick Fix for ToDo" },
    },

    -- INSERT MODE
    i = {
        ["<A-h>"] = { function()
            require("terminal").hide_terminals()
        end, desc="Hide Terminal" },
        ["<C-h>"] = { "<LEFT>", desc="Move Left in Insert Mode" },
        ["<C-j>"] = { "<DOWN>", desc="Move Down in Insert Mode" },
        ["<C-k>"] = { "<UP>", desc="Move Up in Insert Mode" },
        ["<C-l>"] = { "<RIGHT>", desc="Move Right in Insert Mode" },
        ["<C-b>"] = { "<ESC>^i", desc="Move to Beginning of Line" },
        ["<C-e>"] = { "<ESC>$a", desc="Move to End of Line" },
    },
    -- terminal mode (used for interacting with the terminal ie inserting)
    t = {
        ["<C-x>"] = { [[<C-\><C-n>]], desc="Exit Terminal Mode" },
        -- Add window move commands in terminal
        ["<C-h>"] = {"<cmd>wincmd h<CR>", desc="Move window left"},
        ["<C-l>"] = {"<cmd>wincmd l<CR>", desc="Move window right"},
        ["<C-j>"] = {"<cmd>wincmd j<CR>", desc="Move window down"},
        ["<C-k>"] = {"<cmd>wincmd k<CR>", desc="Move window up"},
        -- Hide terminal
        ["<A-h>"] = { function()
            require("terminal").hide_terminals()
        end, desc="Hide Terminal" },
    },
    -- Visual Mode
    v = {
        ["<C-e>"] = { "$", desc="Move to End of Line" },
        ["<C-b>"] = { "^", desc="Move to Beginning of Line" }
    }

}

M.term = {
    i = {
        ["<C-n>"] = { "<C-\\><C-n>", desc="Enter Terminal Normal Mode" },
    }
}
-- TELESCOPE -- 
M.telescope = {
    n = {
        ["<leader>ff"] = { ":Telescope find_files<CR>", desc="Find File" },
        ["<leader>fm"] = { ":Telescope lsp_document_symbols symbols=function<CR>", desc="Search Functions in CurBuf" },
        ["<leader>fw"] = {function ()
            require("telescope.builtin").grep_string({word_match="-w", cwd=vim.loop.cwd()})
        end, desc="Find Word (root)"},
        ["<leader>fW"] = {function ()
            require("telescope.builtin").grep_string({word_match="-w"})
        end, desc="Find Word (root)"},
        ["<leader>fM"] = {":Telescope man_pages<CR>", desc="Find Man Page"},
        ["<leader>fH"] = {":Telescope help_pages<CR>", desc="Find Help Page"},
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
            end, desc="Find Symbols in Buffer"},
        ["<leader>ft"] = {":Telescope colorscheme<CR>", desc="Find Colour Schemes"}


    },
    v = {
        ["<leader>fw"] = {function ()
            require("telescope.builtin").grep_string({word_match="-w", cwd=vim.loop.cwd()})
        end, desc="Find Word (root)"},
    }
}

M.dap = {
    n = {
        ["<leader>db"] = {"<cmd>DapToggleBreakpoint<CR>", desc="Toggle Breakpoint"}
    },
}

M.dap_python = {
    n={
        ["<leader>dpr"] = {function()
            require("dap-python").test_method()
            
        end}
    }
}
return M
