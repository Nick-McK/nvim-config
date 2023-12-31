local M = {}

-- keymaps are defined as ["keymap_to_set"] = {"command_to_execute", options}
-- options is anything that can be passed to keymap.set() in the table arg and doesn't need to be wrapped within a table
--@param mappings: table of mappings defined in mappings.lua
M.load_mappings = function(m)
    for plug,_ in pairs(m) do
        for mode, maps in pairs(_) do
            for key_map, cmd in pairs(maps) do
                -- Convert everything after the command to execute to be options of
                -- keymap.set()
                local options = {}
                local execute_cmd = cmd
                if type(cmd) == "table" then
                    execute_cmd = cmd[1]
                    options = vim.tbl_deep_extend("force", options, cmd)
                    options[1] = nil
                end
                if plug == "telescope" then
                    -- print("mode", mode)
                    -- print("setting", key_map)
                    -- print("cmd", vim.inspect(execute_cmd))
                end
                vim.keymap.set(mode, key_map, execute_cmd, options)
            end
        end
    end
end
return M
