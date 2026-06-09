return {
  -- cmd = {"clangd", "--compile-commands-dir=."},
  -- cmd = {"sudo", "docker", "exec", "-i", "clang", "clangd", "--path-mappings="},
  cmd = {"sudo", "/home/nick/.config/nvim/lsp/dev_container.sh"},
  filetypes = {"c", "cpp"},
}
