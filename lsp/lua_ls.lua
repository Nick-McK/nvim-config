-- Get all .lua files in the current project and add those directories to
-- the workspace so we can get LSP stuff without needing to open the files
local function get_workspace_libs()
  local cwd = vim.fn.getcwd()
  local dirs = {}
  for _, path in ipairs(vim.fn.glob(cwd .. "/**/*.lua", false, true)) do
    local dir = vim.fn.fnamemodify(path, ":h")
    dirs[dir] = true
  end
  local lib = {}
  for dir, _ in pairs(dirs) do
    table.insert(lib, dir)
  end
  return lib
end


return {
  cmd = {"lua-language-server"},
  filetypes = {"lua"},
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim",
          "game" -- factorio
        }
      },
      workspace = {
        checkThirdParty = false,
        library = vim.tbl_extend(
          "force",
          get_workspace_libs(),
          {"/usr/local/lib/lua/5.4/socket/"},
          {vim.fn.expand("$HOME/dev/Factorio/API/factorio/")}
        )
      }
    }
  }

}
