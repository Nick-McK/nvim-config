return {
    dir = "~/dev/plugins/BufBuddy/",
    config = function()
      local buf_buddy = require("BufBuddy"):setup({
        mappings = {
          open = "<leader><leader>"
        },
        win_opts = {
          width = 90,
          height = 5
        },
        use_absolute_paths = false,
        use_default_buffer_list = false
      })
    end
}
