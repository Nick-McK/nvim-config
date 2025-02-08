return {
    {
        "luisiacc/gruvbox-baby",
        priority = 1000,
        config = function()
            -- vim.g.gruvbox_baby_highlights = {}
            vim.g.gruvbox_baby_transparent_mode = true
            vim.cmd.colorscheme("gruvbox-baby")
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = {
            transparent_mode = true
        }
    },
    {
      "sainnhe/gruvbox-material",
      priority = 1000,
      config = function()
        vim.g.gruvbox_material_transparent_background = 1
      end,
    }
}
