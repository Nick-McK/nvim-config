return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            styles = {
                transparency = false,
                italic = true,
                bold = true,
            },
            palette = {
                moon = {
                    -- base = "#180020",
                    base = "#111111",
                }
            },
            -- group = {
            --     background = "#000000"
            -- },
        })
    end
}
