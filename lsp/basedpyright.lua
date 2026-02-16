return {
  cmd = {"basedpyright-langserver", "--stdio"},
  filetypes = {"python"},
  root_markers = {
    "src", -- custom pattern. Pyright can have issues depending on project structure
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git"
  },
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    }
  }
}
