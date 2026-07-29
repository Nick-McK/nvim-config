local M = {}
local highlights = {}

vim.cmd("highlight clear")

local c = {
  background="#101010",
  white = "#D8DEE9",
  -- white = "#f2e5bc",
  -- offwhite = "#dfdfaf",
  -- offwhite = "#e7e6d0",
  offwhite = "#fffee2",
  -- yellow_muted = "#ffe6b5",
  yellow_muted = "#fffd96",
  violet = "#b294bb",
  purple_vivid = "#8e6fbd",
  grey = "#878787",
  red = "#c98996",
  red_soft = "#af8787",
  red_dark = "#875f5f",
  purple_soft = "#ab75ae",
  green = "#86ae75"
}

highlights.base = {
  ["Normal"] = { fg=c.offwhite, bg=c.background },
  ["Function"] = { fg=c.yellow_muted },
  ["Statement"] = { fg=c.violet },
  ["String"] = { fg=c.green },
  ["Type"] = { fg=c.red_dark},
  ["@constant"] = { fg=c.red },
  ["@lsp.type.parameter"] = {fg=c.grey},
  ["@lsp.type.property"] = {fg=c.offwhite}
}

-- Language specifics

-- hl("@constant",                                     { fg=c.red })
-- -- hl("@lsp.mod.readonly.typescript",                                     { fg=c.red })
-- hl("@lsp.type.parameter",                           { fg=c.offwhite })
--
-- hl("@string",                                       { fg=c.green })
--
-- hl("@keyword",                                      { fg=c.violet })
-- hl("@keyword.faded",                                { fg=c.violet })
-- hl("Statement",                                      { fg=c.violet })
--
-- hl("@variable.member",                              { fg=c.violet })
-- hl("@variable",                                     { fg=c.offwhite })



M.setup = function()
  for _, highlight in pairs(highlights) do
    for name, opts in pairs(highlight) do
      vim.api.nvim_set_hl(0, name, opts)
    end
  end
end

M.setup()

return M
