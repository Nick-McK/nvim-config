return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      progress = {
        enabled = true
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      }
    },
    views = {
      cmdline_popup = {
        border = {
          style = "none"
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      filter_options = {},
      win_options= {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
      }

    },
    presets = {
      long_message_to_split = true,
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  }
}
