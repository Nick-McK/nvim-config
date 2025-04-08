return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {"saghen/blink.cmp"},
    config = function(_, opts)
      local servers = {
        pyright = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(
            "src", -- custom pattern. Pyright can have issues depending on project structure
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
            ".git"
            )(fname)
          end,
        },
        vtsls = { -- typescript/javascript
          server_capabilities = {
            documentFormattingProvider = false -- ?
          }
        },
        clangd = {
          cmd = {"clangd", "--compile_commands-dir=."}
        },
        lua_ls = {
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
        },
        ocamllsp = {
          manual_install = true,
          settings = {
            codelens = {enable = true},
            inlayHints = {enable = true},
            syntaxDocumentation = {enable = true}
          }
        },
        bashls = true,
        jsonls = true
      }


      local lspconfig = require("lspconfig")

      local capabilities = require("blink.cmp").get_lsp_capabilities() or
      vim.lsp.protocol.make_client_capabilities()

      local options = {}
      local on_attach = function(client, buf)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

          local builtin = require("telescope.builtin")
          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", builtin.lsp_definitions, {buffer = buf})
          vim.keymap.set("n", "gr", builtin.lsp_references, {buffer = buf})
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {buffer = buf})
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = buf})
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {buffer = buf})
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {buffer = buf})
          vim.keymap.set({ "i", "n" }, '<C-s>', vim.lsp.buf.signature_help, {buffer = buf})
      end
      capabilities.textDocument.completion.completionItem = {
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
      for server, config in pairs(servers) do
        local server_config = {}
        if config == true then
          config = {}
        end
        server_config.capabilities = capabilities
        server_config.on_attach = on_attach
        server_config = vim.tbl_deep_extend("force", server_config, config)
        lspconfig[server].setup(server_config)
      end

      -- local pyright = {
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      --   root_dir = function(fname)
      --     local util = require("lspconfig.util")
      --     return util.root_pattern(
      --       "src", -- custom pattern. Pyright can have issues depending on project structure
      --       "pyproject.toml",
      --       "setup.py",
      --       "setup.cfg",
      --       "requirements.txt",
      --       "Pipfile",
      --       "pyrightconfig.json",
      --       ".git"
      --     )(fname)
      --   end,
      --   settings = {
      --     pyright = {
      --       useLibraryReturnTypes = true
      --     }
      --   },
      -- }
      -- lspconfig.pyright.setup(pyright)

    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "clangd",
        "lua_ls",
        "vtsls",
        "bashls",
        "jsonls"
      },
      automatic_installation = true
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end
  }
}
