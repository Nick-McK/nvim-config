local functions = require("core.functions")
local utils = require("core.utils")

local M = {}
-- TODO: Sort all these out and format them in some way
M.general = {
    n = {
      ["<leader>blackout"] = {function()
        vim.api.nvim_set_hl(0, "Normal", {bg="#111111"})
        vim.api.nvim_set_hl(0, "NormalNC", {bg="#111111"})
        vim.api.nvim_set_hl(0, "EndOfBuffer", {bg="#111111"})
      end, desc="Blackout background"},
      -- BufBuddy testing
        -- ["j"] = {"<C-e>", desc="move line down"},
        -- ["k"] = {"<C-y>", desc="move line up"},
        ["<A-R>"] = {"<cmd>source %<cr>", desc="source current file"},

        ["<leader>sl"] = {"<cmd>set list<cr>", desc="Sets char list"},
        ["<leader>sln"] = {"<cmd>set nolist<cr>", desc="Unsets char list"},
        -- navigation prettier
        ["<C-u>"] = {"<C-u>zz", desc="Half page up"},
        ["<C-d>"] = {"<C-d>zz", desc="Half page down"},

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
        -- ["<A-j>"] = {"<cmd>cnext<cr>", desc="Next Quickfix"},
        -- ["<A-k>"] = {"<cmd>cprev<cr>", desc="Previous Quickfix"},
        ["<A-j>"] = {function()
          -- organise quick fix list first so it takes priority if its open
          if utils.is_window_open("qf") then
            vim.api.nvim_command("cnext")
          elseif utils.is_window_open("aerial") then
            vim.api.nvim_command("AerialNext")
          end
        end, desc="Previous quick fix or aerial"},
        ["<A-k>"] = {function()
          -- organise quick fix list first so it takes priority if its open
          if utils.is_window_open("qf") then
            vim.api.nvim_command("cprev")
          elseif utils.is_window_open("aerial") then
            vim.api.nvim_command("AerialPrev")
          end
        end, desc="Previous quick fix or aerial"},

        ["<leader>ve"] = {
            function()
                vim.diagnostic.open_float({border = "rounded"})
            end, desc="Inspect Error Message"
        },

        ["<C-n>"] = { ":lua require('oil').toggle_float()<CR>", desc="Toggle Nvim Tree" },
        -- ["<C-n>"] = { "<cmd>Oil<cr>", desc="Toggle Nvim Tree" },
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

    -- Set command mode keybinds for starting completion, cycling next/prev
    -- and accepting but not entering a completion item
    c = {
      ["<C-j>"] = {function()
        if vim.fn.pumvisible() == 1 then return "<C-n>" end
        if vim.fn.wildmenumode() == 1 then return "<Tab>" end
        local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
        vim.api.nvim_feedkeys(tab, "t", false)
        return "" -- already submitted the key to the term with feedkeys
      end, desc="Next Item", expr=true, noremap=true},

      ["<C-k>"] = {function()
        if vim.fn.pumvisible() == 1 then return "<C-p>" end
        if vim.fn.wildmenumode() == 1 then return "<S-Tab>" end
        local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
        vim.api.nvim_feedkeys(tab, "t", false)
        return "" -- already submitted the key to the term with feedkeys
        -- return "<S-Tab>"
      end, desc="Previous Item", expr=true, noremap=true},

      ["<C-space>"] = {function()
        if vim.fn.pumvisible() == 1 then return "<C-y>" end
        if vim.fn.wildmenumode() == 1 then return "<C-y>" end

        local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
        vim.api.nvim_feedkeys(tab, "t", false) -- "t" = treat as keycodes
        return ""
      end, desc="Accept Completion", expr = true, noremap = true }
    }
}

M.telescope = {
    n = {
        -- ["<leader>ff"] = { "<cmd>Telescope find_files<CR>", desc="Find File" },
        ["<leader>fd"] = { function()
            local no_preview_drop_down = require("plugins.ui.telescope").no_preview
            return require("telescope.builtin").find_files(no_preview_drop_down)
        end, desc="Find File" },
        ["<C-f>"] = { function()
          local dynamic_height = require("utils.telescope-utils").dynamic_height()
          return require("telescope.builtin").find_files(dynamic_height)
        end, desc="Find File" },

        ["<leader>sf"] = { ":Telescope lsp_document_symbols symbols=function,method<CR>", desc="Search Functions in CurBuf" },
        ["<leader>fw"] = {function ()
            require("telescope.builtin").grep_string({word_match="-w", cwd=vim.loop.cwd()})
        end, desc="Find Word (root)"},
        ["<leader>fM"] = {":Telescope man_pages<CR>", desc="Find Man Page"},
        ["<leader>fh"] = {"<cmd>Telescope help_tags<cr>", desc="Find Help Page"},
        ["<leader>fb"] = {":Telescope current_buffer_fuzzy_find<CR>", desc="Search Buffer"},
        -- ["<leader>fd"] = {":Telescope diagnostics bufnr=0<CR>", desc="Current Buffer Diagnostics"},
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
        -- ["<C-e>"] = {"<CMD>Telescope buffers<CR>", desc="Search Open Buffers"},

        ["<A-m>"] = {"<CMD>Telescope marks<CR>", desc="Search Open Buffers"},
        ["<leader>fp"] = {function() require("telescope.builtin").find_files({
                cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
            })
        end}


	},
}


M.lspconfig = {
	n = {
		["<leader>li"] = { "<CMD>LspInfo<CR>", desc = "LSP Info" },
		["<leader>lr"] = { "<CMD>LspRestart<CR>", desc = "LSP Restart" },
    },
}

M.gitsigns = {
  n = {
    ["<leader>tnh"] = {"<cmd>Gitsigns toggle_numhl<cr>", desc="Toggle Number Highlight"},
    ["<leader>gsh"] = {"<cmd>Gitsigns stage_hunk<cr>", desc="Stage Hunk"},
    ["[h"] = {"<cmd>Gitsigns prev_hunk<cr>", desc="Previous Hunk"},
    ["]h"] = {"<cmd>Gitsigns next_hunk<cr>", desc="Previous Hunk"},
  }
}

M.BufBuddy = {
  n = {
    ["]b"] = {function() require("BufBuddy"):next() end, desc="Next Buffer"},
    ["<Tab>"] = {function() require("BufBuddy"):next() end, desc="Next Buffer"},
    ["[b"] = {function() require("BufBuddy"):prev() end, desc="Next Buffer"},
    ["<S-Tab>"] = {function() require("BufBuddy"):prev() end, desc="Next Buffer"},
  }
}

M.fyler = {
  n = {
    ["<leader>e"] = {"<cmd>Fyler kind=split_left_most<cr>"}
  }
}

M.refer = {
  n = {
    ["<M-f>"] = {"<cmd>Refer Files<cr>", desc="Open Files"}
  }
}

-- M.aerial = {
--   n = {
--     ["<M-d>"] = {"<cmd>AerialNext<cr>", desc="Aerial Cycle Next"},
--     ["<M-a>"] = {"<cmd>AerialPrev<cr>", desc="Cycle Aerial Back"}
--   }
-- }

return M
