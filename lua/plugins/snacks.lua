local function dynamic_ivy_height(opts)
  opts = vim.tbl_extend("force", {
    min = 2,      -- minimum result rows
    max = 14,     -- maximum result rows
    extra = 3,    -- input row + borders/title padding for ivy
  }, opts or {})

  return function(picker)
    if picker._dynamic_ivy_height_attached then
      return
    end
    picker._dynamic_ivy_height_attached = true

    local last_height
    local scheduled = false

    local function desired_height()
      local count = picker.list and picker.list:count() or 0
      local result_rows = math.max(opts.min, math.min(count, opts.max))
      return result_rows + opts.extra
    end

    local function resize()
      scheduled = false

      if picker.closed or not picker.layout or not picker.layout:valid() then
        return
      end

      local height = desired_height()
      if height == last_height then
        return
      end

      last_height = height

      -- For ivy / ivy_split, this is the root picker height.
      picker.layout.opts.layout.height = height

      -- Keep Snacks' resolved layout in sync too.
      if picker.resolved_layout and picker.resolved_layout.layout then
        picker.resolved_layout.layout.height = height
      end

      picker.layout:update()
    end

    local function schedule_resize()
      if scheduled then
        return
      end
      scheduled = true
      vim.schedule(resize)
    end

    local original_update = picker.list.update

    picker.list.update = function(list, ...)
      local ret = original_update(list, ...)
      schedule_resize()
      return ret
    end

    schedule_resize()
  end
end

return {
  "folke/snacks.nvim",
  dependencies = {
    "folke/todo-comments.nvim",
    keys = {
      {
        "td",
        function()
          Snacks.picker.todo_comments()
        end,
        desc="[T]odo"
      },
      {
        "tn",
        function()
          Snacks.picker.todo_comments({keywords = {"NMTODO", "NMNM"}})
        end,
        desc="[T]odo [N]ick"}
    }
  },
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = {
      sources = {
        smart = {
          on_show = dynamic_ivy_height({
            min = 1,
            max = 14,
            extra = 3
          }),
        },
        lines = {
          on_show = dynamic_ivy_height({
            min = 1,
            max = 14,
            extra = 3
          }),
        },
      },
      smart = {
        multi = { "buffers", "recent", "files" },
        format = "file",
        matcher = {
          cwd_bonus = true,
          frecency = true,
        },
      },
      layout = {
        preset = "ivy",
        preview = "main",
        layout = {
          backdrop = false
        }
      },
      filter = { cwd = true },
      debug = {
        score = true
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dim = { enabled = false },
    debug = { enabled = true },
    lazygit = { enabled = true }
  },
  keys = {
    { "<leader>fs", function() Snacks.picker() end, desc="[F]ind [S]nacks - Open Snacks picker"},
    { "<leader>fe", function() Snacks.explorer() end, desc = "[F]ile [E]xplorer" },
    { "<leader>fm", function() Snacks.picker.man() end, desc = "[F]ind [M]an"},
    { "<leader>fh", function() Snacks.picker.help() end, desc="[F]ind [H]elp"},
    { "<C-f>", function() Snacks.picker.smart() end, desc="[F]ind [F]ile"},
    { "<leader>fb", function() Snacks.picker.lines() end, desc="[F]ind [L]ines"},
    { "<leader>lg", function() Snacks.lazygit() end, desc = "[L]azy [G]it"},
    { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, desc="[F]ind [D]iagnostics Buffer"},
    { "<leader>fD", function() Snacks.picker.diagnostics() end, desc="[F]ind [D]iagnostics"},
    { "<leader>fg", function() Snacks.picker.grep() end, desc="[F]ind [G]rep"},
    { "<leader>ft", function() Snacks.picker.colorschemes() end, desc="[F]ind [T]heme"},
    { "<A-m>", function() Snacks.picker.marks() end, desc="[M]arks"},
    { "<leader>fH", function() Snacks.picker.highlights() end, desc="[F]ind [H]ighlights"},
  }
}
