# nvim-config
personal nvim config

# Setting up clangd and QT
- install qt6 (sudo apt install qt6-base-dev)
    - This will provide qmake in /usr/lib/qt6/bin/
- Use qmake to generate makefile (/usr/lib/qt6/bin/qmake -o Makefile tui.pro)
    - Build a make file from the tui.pro file that we write
- install bear (sudo apt install bear) or cmake can be used (cmake DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..)
    - This will allow us to generate a compile_commands.json <- this is the thing that is used to provide the code completion
- Run bear to generate the compile_commands.json (bear -- /usr/lib/qt6/bin/qmake && bear -- make)
    - This intercepts the qmake commands? and then the make commands? (don't really understand this but both are required when using bear)

- Finally, in clangd lspconfig run cmd = clangd --compile_commands-dir=.


