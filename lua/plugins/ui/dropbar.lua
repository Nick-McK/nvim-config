return {
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  config = function()
    require("dropbar").setup({
      sources = {
        path = {
          max_depth = 1,
          filter = function() return false end
          }
        },
        -- Default bar.sources but removed all references to sources.path
        bar = {
          sources = function(buf, _)
            local sources = require('dropbar.sources')
            local utils = require("dropbar.utils")
            if vim.bo[buf].ft == 'markdown' then
              return {
                sources.markdown,
              }
            end
            if vim.bo[buf].buftype == 'terminal' then
              return {
                sources.terminal,
              }
            end
            return {
              utils.source.fallback({
                sources.lsp,
                sources.treesitter,
              }),
            }
          end,
        }
    })
  end
}

