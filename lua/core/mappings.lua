local M = {}

M.general = {
    n = {
        ["<leader>qq"] = { ":qa!<CR>", "Force quite all no saving" },
        [";"] = { ":", "Open Command Mode" },
        ["<C-b>"] = { "^", "Move to Beginning of Line" },
        ["<C-e>"] = { "$", "Move to End of Line" },

        -- Telescope
        ["<leader>ff"] = { "<CMD>:Telescope find_files<CR>", "Find Files" },
        ["<C-b>"] = { "<CMD>:Ex<CR>", "Opens File Tree" },

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
                local term = require("core.terminal")
                print("wtf is this", term.terminal_horizontal())
            end, "Opens Horizontal Terminal" },
        ["<leader>vt"] = {
            function()
                local term = require("core.terminal")
                print("wtf is this", term.terminal_vertical())
            end, "Opens Horizontal Terminal" },
        -- DEBUG WINDOW
        ["<leader>dw"] = { function()
            local term = require("core.terminal")
            term.debug()
        end, "Terminal debugging" },
        -- opens floating terminal
        ["<leader>ft"] = {
            function()
                local term = require("core.terminal")
                term.open_term()
                -- print("wtf is this", term.term_table[1].id)
            end, "Opens Floating Terminal" },
        -- Hide terminal
        ["<A-h>"] = {
            function()
                local term = require("core.terminal")
                term.hide_terminals()
                
                -- print("wtf is this", term.term_table[1].win)
            end, "Shows Terminals" },
        -- Show floating terminal
        ["<leader>sft"] = {
            function()
                local term = require("core.terminal")
                term.show_terminal()
                -- print("wtf is this", term.term_table[1].win)
            end, "Shows Terminals" },
        -- Jump to context
        ["<leader>gcc"] = {
            function()
                require('treesitter-context').go_to_context()
            end, "Jumps to Current Context" },
    },

    -- INSERT MODE
    i = {
        ["<A-h>"] = {function()
            require("core.terminal").hide_terminals()
        end, "Hide Terminal"},
        ["<C-h>"] = {"<LEFT>", "Move Left in Insert Mode"},
        ["<C-j>"] = {"<DOWN>", "Move Down in Insert Mode"},
        ["<C-k>"] = {"<UP>", "Move Up in Insert Mode"},
        ["<C-l>"] = {"<RIGHT>", "Move Right in Insert Mode"},
    },
    -- terminal mode (used for interacting with the terminal ie inserting)
    t = {
        ["<C-x>"] = { [[<C-\><C-n>]], "Exit Terminal Mode" },
        -- Hide terminal
        ["<A-h>"] = {function()
            require("core.terminal").hide_terminals()
        end, "Hide Terminal"},
    }

}

M.term = {
    i = {
        ["<C-n>"] = { "<C-\\><C-n>", "Enter Terminal Normal Mode" },
    }
}

return M
