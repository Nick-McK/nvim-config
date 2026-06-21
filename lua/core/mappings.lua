local functions = require("core.functions")
local utils = require("core.utils")

local M = {}
-- TODO: Sort all these out and format them in some way
M.general = {
  n = {
    ["<A-R>"] = {"<cmd>source %<cr>", desc="source current file"},

    ["<leader>sl"] = {"<cmd>set list<cr>", desc="Sets char list"},
    ["<leader>sln"] = {"<cmd>set nolist<cr>", desc="Unsets char list"},

    ["<C-u>"] = {"<C-u>zz", desc="Half page up"},
    ["<C-d>"] = {"<C-d>zz", desc="Half page down"},

    ["<C-j>"] = { "<C-w>j", desc="Move Down a Window" },
    ["<C-k>"] = { "<C-w>k", desc="Move Up a Window" },
    ["<C-h>"] = { "<C-w>h", desc="Move Left a Window" },
    ["<C-l>"] = { "<C-w>l", desc="Move Right a Window" },
    -- Window splits
    ["<leader>hw"] = { "<CMD>split | wincmd j<CR>", desc="New Horizontal Window" },
    ["<leader>vw"] = { "<CMD>vsp | wincmd l<CR>", desc="New Vertical Window" },

    ["<A-s>"] = { "<CMD>belowright 15split | wincmd j | term<CR>", desc="New Horizontal Terminal" },
    ["<A-v>"] = { "<CMD>100vsp | wincmd l | term<CR>", desc="New Vertical Terminal" },

    -- resize splits better
    ["<A-H>"] = { "<CMD>wincmd 2 <<CR>"},
    ["<A-J>"] = { "<CMD>wincmd 2 -<CR>"},
    ["<A-K>"] = { "<CMD>wincmd 2 +<CR>"},
    ["<A-L>"] = { "<CMD>wincmd 2 ><CR>"},

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
      end, desc="[V]iew [E]rror"
    },


    ["<C-t>"] = {function()
      if functions.state.cc == false then
        functions.toggle_custom_color_col()
      else
        functions.clear_custom_color_col()
      end
    end, desc="testing"},
  },

  -- INSERT MODE
  i = {
    ["<C-h>"] = { "<LEFT>", desc="Move Left in Insert Mode" },
    ["<C-j>"] = { "<DOWN>", desc="Move Down in Insert Mode" },
    ["<C-k>"] = { "<UP>", desc="Move Up in Insert Mode" },
    ["<C-l>"] = { "<RIGHT>", desc="Move Right in Insert Mode" },
  },

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


M.lspconfig = {
  n = {
    ["<leader>li"] = { "<CMD>LspInfo<CR>", desc = "LSP Info" },
    ["<leader>lr"] = { "<CMD>LspRestart<CR>", desc = "LSP Restart" },
  },
}

M.BufBuddy = {
  n = {
    ["]b"] = {function() require("BufBuddy"):next() end, desc="Next Buffer"},
    ["<Tab>"] = {function() require("BufBuddy"):next() end, desc="Next Buffer"},
    ["[b"] = {function() require("BufBuddy"):prev() end, desc="Next Buffer"},
    ["<S-Tab>"] = {function() require("BufBuddy"):prev() end, desc="Next Buffer"},
  }
}

M.refer = {
  n = {
    ["<M-f>"] = {"<cmd>Refer Files<cr>", desc="Open Files"}
  }
}

return M
