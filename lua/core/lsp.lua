-- For every .lua file we find in .config/nvim/lsp/ we get the file name and then
-- use it to enable the lsp
local lsp_files = {}
local lsp_dir = vim.fn.stdpath("config") .. "/lsp/"

for _, file in ipairs(vim.fn.globpath(lsp_dir, "*.lua", false, true)) do
  -- :t gets file name
  -- :r removes extension
  local open_file = io.open(file, "r")
  local first_line = open_file:read("*l")

  local name = vim.fn.fnamemodify(file, ":t:r")
  if not first_line:find("-- disable") then
    table.insert(lsp_files, name)
  end

end

vim.lsp.enable(lsp_files)

local capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
vim.lsp.config("*", {capabilities = capabilities})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- if not client then
        --     return
        -- end


        ---[[ Disable default formatting
        if client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
        end

        if client.name == "lua_ls" then
            client.server_capabilities.documentFormattingProvider = false
        end
        ---]]

        ---[[ Lsp Keymaps
        local nmap = function(keys, func, desc)
            if desc then
                desc = "LSP: " .. desc
            end
            vim.keymap.set("n", keys, func, { buffer = args.buf, noremap = true, silent = true, desc = desc })
        end

        nmap("K", vim.lsp.buf.hover, "Open hover")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("gr", vim.lsp.buf.references, "References")
        nmap("ca", vim.lsp.buf.code_action, "Code action")
        nmap("gd", vim.lsp.buf.definition, "Goto definition")
        nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
        -- Not sure i'll use these
        nmap("<leader>ds", "<cmd>vs | lua vim.lsp.buf.definition()<cr>", "Goto definition (v-split)")
        nmap("<leader>dh", "<cmd>sp | lua vim.lsp.buf.definition()<cr>", "Goto definition (h-split)")

        vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = args.buf })
        vim.keymap.set("n", "<M-s>", vim.lsp.buf.signature_help, { buffer = args.buf })

        -- inlay hints
        nmap("<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle inlay hints")

        vim.api.nvim_buf_create_user_command(args.buf, "Fmt", function(_)
            vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
        ---]]

    end,
})
