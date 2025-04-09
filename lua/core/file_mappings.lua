local utils = require("core.utils")
local saved_keymaps = {}
local function save_original_keymap(lhs)
    local map = vim.fn.maparg(lhs, "n", false, true)
    if map and map.lhs ~= "" then
        saved_keymaps[lhs] = map
    end
end

local function restore_keymap(lhs)
  if lhs == nil then
    return
  end
  local map = saved_keymaps[lhs]
  if map and next(map) ~= nil then
    vim.keymap.set(
    map.mode,
    map.lhs,
    map.rhs,
    {
      expr = map.expr == 1,
      noremap = map.noremap == 1,
      silent = map.silent == 1,
      nowait = map.nowait == 1,
      desc = map.desc,
    }
    )
  else
    pcall(vim.keymap.del, "n", lhs) -- clean up if no saved map
  end
end

local win_states = {
  qf = false,
  aerial = false
}
vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "qf",
  callback = function(ev)
    local keys = {"<A-n>", "<A-p>"}
    for _, key in ipairs(keys) do
      save_original_keymap(key)
    end

    win_states.qf = true

    vim.keymap.set("n", "<A-n>", "<cmd>cnext<cr>")
    vim.keymap.set("n", "<A-p>", "<cmd>cprev<cr>")


  end
})

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "aerial",
  callback = function(ev)
    local keys = {"<A-j>", "<A-k>"}
    for _, key in ipairs(keys) do
      save_original_keymap(key)
    end

    win_states.aerial = true

    vim.keymap.set("n", "<A-j>", "<cmd>AerialNext<cr>")
    vim.keymap.set("n", "<A-k>", "<cmd>AerialPrev<cr>")
  end
})

vim.api.nvim_create_autocmd({"BufWinLeave"}, {
  callback = function(ev)
    if utils.is_window_open("qf") == false and win_states.qf == true then
      local keys = {"<A-n>", "<A-p>"}
      for _, key in ipairs(keys) do
        restore_keymap(key)
      end
      win_states.qf = false
    elseif utils.is_window_open("aerial") == false and win_states.aerial == true then
      local keys = {"<A-j>", "<A-k>"}
      for _, key in ipairs(keys) do
        restore_keymap(key)
      end
      win_states.aerial = false
    end
  end
})

