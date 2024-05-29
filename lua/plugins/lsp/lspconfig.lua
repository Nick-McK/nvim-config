--local capabilities = require("cmp_nvim_lsp").default_capabilities()
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

local options = {}
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
local lua = {
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

local pyright = {
    capabilities = options.capabilities,
    pyright = {
		-- Specify libraries that the lsp should use for code completion
        library = {
            "~/dev/Factorio/"
        }
    }
}

local basedpyright = {
    capabilities = options.capabilities,
}

local clangd = {
	-- To get QTModules to show up in the lsp the compile_commands.json needs to be generated
	-- The LSP then uses this and the Makefile to give completion?/hints? For more info on setup see README

	-- cmd = {"clangd", "--compile-commands-dir=."},
	cmd = {"clangd", "--compile-commands-dir=./build/"},
	capabilities = options.capabilities,

}

local jdtls = {
	capabilities = options.capabilities,
}


return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup(lua)
		lspconfig.pyright.setup(pyright)
		-- require("lspconfig").basedpyright.setup({})
		lspconfig.basedpyright.setup(basedpyright)
		--lspconfig.pyright.setup(html)
		lspconfig.clangd.setup(clangd)
		lspconfig.jdtls.setup(jdtls)
	end
}
