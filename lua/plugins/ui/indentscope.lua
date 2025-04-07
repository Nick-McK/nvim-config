return {
  {
    "echasnovski/mini.indentscope",
    config = function()
       require("mini.indentscope").setup({
              symbol = "│",
            -- options={try_as_border=true},
           })
    end,
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   --- @module "ibl"
  --   --- @type ibl.config
  --   opts = {}
  -- }
}
