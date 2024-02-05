-- mappings = {some = {"table", "values"}}
local M = {}
M.mappings = {
    n = {
        {"<C-h>", "<C-w>h", {desc="this is a description"}},
        ["<C-h>"] = {"<C-w>h", {desc="this is a description"}},
    }
}
-- keymaps are defined as ["keymap_to_set"] = {"command_to_execute", options}
-- options is anything that can be passed to keymap.set() in the table arg and doesn't need to be wrapped within a table
--@param mappings: table of mappings defined in mappings.lua
M.load_mappings = function(mappings)
    print("mappings: ", vim.inspect(mappings))
    for mode, maps in pairs(mappings.general) do
        print("mode: ", vim.inspect(mode))
        print("maps: ", vim.inspect(maps))
       for key_map, cmd in pairs(maps) do
            -- Convert everything after the command to execute to be options of
            -- keymap.set()
            local options = {}
            local execute_cmd = cmd
            if type(cmd) == "table" then
                print(vim.inspect(cmd))
                execute_cmd = cmd[1]
                options = vim.tbl_deep_extend("force", options, cmd)
                options[1] = nil
            end
            vim.keymap.set(mode, key_map, execute_cmd, options)
            -- print("cmds: ", vim.inspect(cmd))
            -- vim.keymap.set(mode, key_map, cmd[1], cmd)
        end
    end
end
M.load_mappings(require("lua.core.mappings"))
return M
