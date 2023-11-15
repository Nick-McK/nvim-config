local M = {}
-- TODO: Sort all these out and format them in some way
M.general = {
    n = {
        ["<C-q>"] = { ":qa!<CR>", "Force quite all no saving" },
        [";"] = { ":", "Open Command Mode" },
        ["<C-b>"] = { "^", "Move to Beginning of Line" },
        ["<C-e>"] = { "$", "Move to End of Line" },

        -- open theme switcher
        ["<leader>th"] = {function()
            require("colour_picker").open_theme_window()
        end, "Opens Theme Switcher Menu"},

        
        -- Open terminal
        --["<leader>ht"] = {"<CMD>:term<CR>", "Opens Horizontal Terminal"},

        -- Switch windows
        ["<C-j>"] = { "<C-w>j", "Move Down a Window" },
        ["<C-k>"] = { "<C-w>k", "Move Up a Window" }, -- currently doesn't work as there is an overlapping keybind
        ["<C-h>"] = { "<C-w>h", "Move Left a Window" },
        ["<C-l>"] = { "<C-w>l", "Move Right a Window" },
        -- Window splits
        ["<leader>hw"] = { "<C-w>s", "New Horizontal Window" },
        ["<leader>vw"] = { "<C-w>v", "New Vertical Window" },


        -- open horizontal terminal
        ["<leader>ht"] = {
            function()
                require("terminal").terminal_horizontal()
            end, "Opens Horizontal Terminal" },
        ["<leader>vt"] = {
            function()
                require("terminal").terminal_vertical()
            end, "Opens Vertical Terminal" },
        -- DEBUG WINDOW
        ["<leader>dw"] = { function()
            local term = require("terminal")
            term.debug()
        end, "Terminal debugging" },
        -- opens floating terminal
        ["<leader>ft"] = {
            function()
                local term = require("terminal")
                term.open_term()
            end, "Opens Floating Terminal" },
        -- Hide terminal
        ["<A-h>"] = {
            function()
                local term = require("terminal")
                term.hide_terminals()
            end, "Shows Terminals" },

        ["<leader>st"] = {function ()
            local term = require("terminal").show_terminal_list()
        end, "Shows a list of terminals"},


        -- Show floating terminal
        ["<leader>sft"] = {
            function()
                local term = require("terminal")
                term.show_terminal()
                -- print("wtf is this", term.term_table[1].win)
            end, "Shows Terminals" },
        -- Jump to context
        ["<leader>gcc"] = {
            function()
                require('treesitter-context').go_to_context()
            end, "Jumps to Current Context" },




        -- PLUGINS
        ------ BUFFERLINE ------
        ["<leader>1"] = { ":BufferLineGoToBuffer 1<CR>", "Go To Buffer 1" },
        ["<leader>2"] = { ":BufferLineGoToBuffer 2<CR>", "Go To Buffer 2" },
        ["<leader>3"] = { ":BufferLineGoToBuffer 3<CR>", "Go To Buffer 3" },
        ["<leader>4"] = { ":BufferLineGoToBuffer 4<CR>", "Go To Buffer 4" },
        ["<leader>5"] = { ":BufferLineGoToBuffer 5<CR>", "Go To Buffer 5" },
        ["<leader>6"] = { ":BufferLineGoToBuffer 6<CR>", "Go To Buffer 6" },
        ["<leader>7"] = { ":BufferLineGoToBuffer 7<CR>", "Go To Buffer 7" },
        ["<leader>8"] = { ":BufferLineGoToBuffer 8<CR>", "Go To Buffer 8" },
        ["<leader>9"] = { ":BufferLineGoToBuffer 9<CR>", "Go To Buffer 9" },

        -- Close Buffer
        ["<leader>x"] = { ":BufferLinePickClose<CR>", "Pick a Buffer To Close" },
        -- Cycle Buffers
        ["<tab>"] = { ":BufferLineCycleNext<CR>", "Cycle Buffers Right" },
        ["<S-tab>"] = { ":BufferLineCyclePrev<CR>", "Cycle Buffers Left" },
        

        ------ BUFFERLINE END ------
        --
        ------ NVIM TREE ------

        ["<C-n>"] = { ":NvimTreeToggle<CR>", "Toggle Nvim Tree" },
        ["<leader>e"] = { ":NvimTreeFocus<CR>", "Focus Nvim Tree" },
        ------ NVIM TREE END ------
        --
        ------ TELESCOPE ------
        ["<leader>ff"] = { ":Telescope find_files<CR>", "Find File" },
        ["<A-m>"] = { ":Telescope lsp_document_symbols symbols=function<CR>", "Search Functions in CurBuf" },
        ------ TELESCOPE END ------
        --
        ------ TODO COMMENTS ------
        ["td"] = { ":TodoQuickFix<CR>", "Open Quick Fix for ToDo" },
    },

    -- INSERT MODE
    i = {
        ["<A-h>"] = {function()
            require("terminal").hide_terminals()
        end, "Hide Terminal"},
        ["<C-h>"] = {"<LEFT>", "Move Left in Insert Mode"},
        ["<C-j>"] = {"<DOWN>", "Move Down in Insert Mode"},
        ["<C-k>"] = {"<UP>", "Move Up in Insert Mode"},
        ["<C-l>"] = {"<RIGHT>", "Move Right in Insert Mode"},
        ["<C-b>"] = { "<ESC>^i", "Move to Beginning of Line" },
        ["<C-e>"] = { "<ESC>$a", "Move to End of Line" },
    },
    -- terminal mode (used for interacting with the terminal ie inserting)
    t = {
        ["<C-x>"] = { [[<C-\><C-n>]], "Exit Terminal Mode" },
        -- Hide terminal
        ["<A-h>"] = {function()
            require("terminal").hide_terminals()
        end, "Hide Terminal"},
    },
    -- Visual Mode
    v = {
        ["<C-e>"] = {"$", "Move to End of Line"},
        ["<C-b>"] = {"^", "Move to Beginning of Line"}
    }

}

M.term = {
    i = {
        ["<C-n>"] = { "<C-\\><C-n>", "Enter Terminal Normal Mode" },
    }
}

return M
