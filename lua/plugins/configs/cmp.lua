local cmp = require "cmp"
local lspkind = require("lspkind")
-- lspkind.init({})
local opts = {
    completion = {
        completeopt = "menu,menuone"
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    -- window = {
    -- 	completion = cmp.config.window.bordered(),
    -- 	documentation = cmp.config.window.bordered(),
    -- },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- Set ctrl + j to move down in completion
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- ["<C-j>"] = cmp.mapping(
        --     function(fallback)
        --         if cmp.visible() then
        --             cmp.select_next_item()
        --         else
        --             fallback()
        --         end
        --     end, { "i" }),
        -- Set ctrl + k to move up in completion
        -- ["<C-k>"] = cmp.mapping(
        --     function(fallback)
        --         if cmp.visible() then
        --             cmp.select_prev_item()
        --         else
        --             fallback()
        --         end
        --     end, { "i" }),
    }),
    -- The order in which these are placed matters, the higher the order the higher on the completion list an item is
    sources = cmp.config.sources({
        { name = "nvim_lua" },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = "buffer" },
    }),
    experimental = {
        ghost_text = true, -- adds text on the screen for the most likely completion
    },
    formatting = {
        format = lspkind.cmp_format({  
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[PATH]",
                luasnip = "[snip]",
            },
        })
    }
}
return opts
