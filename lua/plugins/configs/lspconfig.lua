local options = {}
local capabilities = require("cmp_nvim_lsp").default_capabilities()
options.on_attach = function(client, buf)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

options.capabilities = vim.lsp.protocol.make_client_capabilities()
-- options.capabilities = require("cmp_nvim_lsp").default_capabilities()
options.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}
-- Setup lua lsp
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
    capabilities = options.capabilities,
    -- on_init= function()
    --     print("$ROOT/usr/local/lib/lua/5.1")
    -- end,
    -- Use the on_init thing if we only want the lsp to work in neovim?
    -- on_init can be found on the lspconfig github or with ;h lspconfig-setup
    settings = {
        Lua = {
            diagnostics = {
                globals = {"vim", "game"}
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    -- Allow the use of the factorio API library
                    ["$HOME/dev/Factorio/API/factorio"] = true,
                    ["/usr/local/lib/lua/5.1/socket"] = true,
                }
            }
        }
    }  
}
-- this sets up the lsp but I would like it to be more user-friendly by adding in something like lspconfig_installed = {"pyright", "ts_server"}
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for all available language servers
lspconfig["pyright"].setup {
    capabilities = options.capabilities,
    pyright = {
        library = {
            "~/dev/Factorio/"
        }
    }
}
-- lspconfig["tsserver"].setup{
--     capabilities = options.capabilities
-- }
lspconfig.svelte.setup {
    capabilities = options.capabilities,
    filetypes = {
        "svelte",
        "javascript",
        "typescript",
        "html",
        "css",
    },
}

lspconfig.html.setup {
    capabilities = options.capabilities,
}
lspconfig.cssls.setup {
    capabilities = options.capabilities,
}
lspconfig.tailwindcss.setup {
    capabilities = options.capabilities,
}
lspconfig.gopls.setup {
	capabilities = options.capabilities,
}
lspconfig.clangd.setup {
	capabilities = options.capabilities,
}
-- lspconfig.ccls.setup {
-- 	capabilities = options.capabilities,
-- 	init_options = {
-- 		cache = {
-- 			directory = ".ccls-cache";
-- 		};
-- 	}
-- }


vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

return options
