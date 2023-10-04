-- TODO: 
--      -Works with only 1 terminal right now
--          -Opening 2 terminals will cause an error and then we can't use the terminal anymore :)
--      - Opening the debug buffer doesn't work when the window width is half
-- open a floating buffer to be terminal

local settings = {
    -- should the terminal buffer be kept alive after using :q command
    close_term_on_exit = true,

}




local term = {}
term.terminal_horizontal = function()
    local term_buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_option(term_buf, "modifiable", true)
    local term_win = vim.api.nvim_open_win(term_buf, true,
        { relative = "editor", width = vim.fn.winwidth(0), height = 20, bufpos = { 100, 10 } })
    vim.api.nvim_win_set_buf(term_win, term_buf)
    -- local job_id = vim.fn.termopen("bash")
    -- local chan = vim.api.nvim_open_term(term_buf, {})
    local chan = vim.fn.termopen("zsh")
    vim.api.nvim_buf_set_option(term_buf, "buftype", "terminal")
end

term.terminal_vertical = function()
    local term_buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_option(term_buf, "modifiable", true)
    local term_win = vim.api.nvim_open_win(term_buf, true,
        { relative = "editor", width = vim.fn.winwidth(0) / 2, height = vim.fn.winheight(0), bufpos = { 100, 10 } })
    vim.api.nvim_win_set_buf(term_win, term_buf)

    local channel = vim.fn.termopen("zsh")
    vim.api.nvim_buf_set_option(term_buf, "buftype", "terminal")
end
-- REQUIRED

-- contains an object of all the active terminals
-- terminals = {
--      id: {
--          type: "horizontal"/"vertical"
--          terminal:
--      }
-- }
local terminals = {}

local function show_terminal()
    -- if there are no terminals then create one
    if #terminals == 0 then
        create_terminal()
    end
end

local function create_terminal()
    -- window config
    -- width is half the screen OR 
    floating_config = {
        relative = "editor",
        width = math.ceil(0.5 * vim.o.columns),
        height = math.ceil(0.4 * vim.o.lines),
        row = math.floor(0.3 * vim.o.lines),
        col = math.floor(0.25 * vim.o.columns),
        border = "single"
    }
    local window = vim.api.nvim_open_win(0, true, floating_config)
    local buffer = vim.api.nvim_create_buf(false, true)
        
    -- Set the buffer to be type terminal - not sure why buftype doesn't work here but it crashes
    vim.api.nvim_buf_set_option(buffer, "filetype", "terminal")
    vim.api.nvim_buf_set_option(buffer, "buflisted", false)
    vim.api.nvim_win_set_buf(window, buffer) -- set window for the terminal buffer
    -- Turn off line numbers in terminal
    vim.wo.relativenumber = false
    vim.wo.number = false

    local job_id = vim.fn.termopen("zsh") -- open terminal in zsh
    local terminal_id = #terminals + 1 -- set id to be the temrinal index. TODO: This is not unique if we create a terminal and then delete (need to change all the id's on delete)
    local terminal = {id=terminal_id, buf=buffer, win=window, job_id=job_id, open=true, hidden=false}
    -- create a terminal map with the terminal id as the key
    --  and the value is the terminal object
    terminals[terminal_id] = {
        term = terminal
    }
    -- print("WINDOW", terminals[1]
    -- table.insert(terminals, terminal) -- insert the newly created terminal into the terminals table
    return terminal
end


local function get_terminal(id)
    -- Gets terminal given an id
    return terminals.id
end


local function get_last_used_terminal()
    -- get the last used terminal
    local n = vim.api.nvim_buf_get_number(terminals[1].term.buf)
    print("bufinfo", vim.bo[n].filetype)
    
    for bufnr = 1, vim.fn.bufnr("$") do
        local is_listed = vim.fn.buflisted(bufnr) == 1
        if vim.bo[bufnr].filetype == "terminal" then
            print("buffer number", vim.fn.bufnr(bufnr))
        end
    end
end
-- Creates a debug buffer and window so that I can write stuff. Printing only works for 1 line - this is also bad, but better than getting single line prints
local function create_debug_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_option(buf, "modifiable", true)
    local main_win_id = vim.fn.win_getid(1)
    print("main", main_win_id)
    local win = vim.api.nvim_open_win(buf, true, { relative = "editor", width = math.ceil(vim.fn.winwidth(main_win_id) / 2), height = vim.fn.winheight(main_win_id), bufpos = { 100, 10 } })
    vim.api.nvim_win_set_buf(win, buf)
    return buf
end


term.debug = function()
    local api = vim.api
    local buf = create_debug_win()
    -- local n = vim.api.nvim_buf_get_number(terminals[1].term.buf)
    -- print("bufinfo", vim.bo[n].filetype)
    local info = vim.fn.getbufinfo({buflisted = 1})
    for i,b in ipairs(info) do
        -- append to the current buffer
        if vim.bo[b.bufnr].filetype == "terminal" then
            vim.fn.append(0, {tostring("TERMINAL BUFFER FOUND " .. b.bufnr)})
        else
            -- paste the buffer number if we have not found the terminal buffer
            vim.fn.append(0, {tostring(b.bufnr)})

        end
    end

    for index, value in ipairs(terminals) do
        vim.fn.append(0, {tostring("index" .. index)})
        for key, val in ipairs(value) do
            vim.fn.append(0, {tostring("value key" .. key)})
            vim.fn.append(0, {tostring("value val" .. val)})
        end
    end

end

-- Opens a terminal
-- TODO: This being used in a loop is breaking everything, need to get the terminal by its id or something
term.open_term = function()
    -- check if there is a terminal open
    if #terminals > 0 then
        for i=1, #terminals, 1 do
            local bufnr = terminals[i].term.buf
            print("buffer number", vim.api.nvim_buf_is_valid(bufnr))
            -- if vim.api.nvim_buf_is_valid(bufnr) then
            --     
            -- end
            if terminals[i].term.open == false and terminals[i].term.hidden == true then
                terminals[i].term.open = true
                terminals[i].term.hidden = false
                terminals[i].term.win = vim.api.nvim_open_win(terminals[i].term.buf, true, floating_config)
            else
                create_terminal()
            end
        end
    else
        create_terminal()
    end

end
-- Showing and hiding working
-- Need to make this pass in a terminal id and not statically use terminal 1
term.hide_terminals = function()
    -- for key, value in ipairs(terminals) do
    --     print("key", key)
    --     print("value",value)
    -- end
    -- Set the open flag to be false
    -- get_last_used_terminal()

    -- print("terms", terminals[1].term.win)
    
    for i = 1, #terminals, 1 do
        term_win = vim.fn.bufwinnr(terminals[i].term.buf)
        print("length term", #terminals)
        -- print("window valid", vim.api.nvim_win_is_valid(terminals[i].term.win))
        print("mod buf", vim.fn.getbufvar(vim.fn.bufnr(), "&hidden"))
        if term_win >= 0 then
            -- print("buffer", terminals[i].term.buf)
            terminals[i].term.open = false
            terminals[i].term.hidden = true
            vim.api.nvim_win_close(terminals[i].term.win, false)
        -- window does not exist for the terminal buffer so set open to false if not already
        else
            terminals[i].term.open = false
        end

        -- terminals[i].term.open = false
        -- vim.api.nvim_win_close(terminals[i].term.win, false)
    end
    -- terminals[1].term.open = false
    -- vim.api.nvim_win_close(terminals[1].term.win, false)
    -- -- print(terminals.)
    -- print(#terminals)

    -- print("currently active terminals", terminals)
    -- print("currently active terminals", terminals.id)
end

term.show_terminal = function()
    -- shows a window with a list of currently active terminals
    terminals[1].term.open = true
    terminals[1].term.win = vim.api.nvim_open_win(terminals[1].term.buf, true, floating_config)
    -- vim.api.nvim_open_win(terminals[1].term.buf, true, floating_config)
end

term.close_terminal = function()
    for i = 1, #terminals, 1 do
        local win_valid = vim.api.nvim_win_is_valid(terminals[i].term.win)
        if not terminals[i].term.hidden and win_valid == 0 then
            vim.api.nvim_command(":bd!")
        end
    end
end

if settings.close_term_on_exit then
    -- term.close_terminal()
    vim.api.nvim_create_autocmd({"WinClosed"}, {
        pattern = {"*"},
        callback = function()
            term.close_terminal()
        end,
    })
    -- vim.api.nvim_create_autocmd({"BufDelete"}, {
    --     pattern = {}
    -- })
end
-- DEBUGGING
term.term_table = terminals
return term
