local function hl(name, data)
  vim.api.nvim_set_hl(0, name, data)
end

local c = {
  offwhite = "#dfdfaf",
  yellow_muted = "#ffe6b5",
  violet = "#b294bb",
  purple_vivid = "#8e6fbd",
  grey = "#878787",
  red = "#c98996",
  purple_soft = "#ab75ae",
  green = "#86ae75"
}

hl("Normal",                                        { fg=c.offwhite, bg="#101010" })
hl("Function",                                      { fg=c.yellow_muted })

hl("@constant",                                     { fg=c.red })
hl("@lsp.type.parameter",                           { fg=c.purple_soft })

hl("@string",                                       { fg=c.green })

hl("@keyword",                                      { fg=c.violet })

hl("@variable.member",                              { fg=c.violet })
hl("@variable",                                     { fg=c.offwhite })


