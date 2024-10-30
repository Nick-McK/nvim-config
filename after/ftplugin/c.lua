vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.cpp", "*.c", "*.h"},
    callback = function()
        vim.keymap.set("n", "gh", function()
            local file_name = vim.fn.expand("%:t")
            local current_file_path = vim.fn.expand("%:p:h")
            local new_file_name

            if vim.fn.expand("%:e") == "h" then
                new_file_name = string.gsub(file_name, ".h", ".cpp", 1)
            elseif vim.fn.expand("%:e") == "cpp" then
                new_file_name = string.gsub(file_name, ".cpp", ".h", 1)
            end

            local new_file = current_file_path .. "/" .. new_file_name

            if vim.fn.filereadable(new_file) == 1 then
                vim.api.nvim_command("edit " .. new_file)
            else
                print("File " .. new_file .. " not readable")
            end
        end)
    end
})
