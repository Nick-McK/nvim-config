-- inspect a table in lua
P = function(t)
    print(vim.inspect(t))
    return t
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

R = function(p)
	RELOAD(p)
	return require(p)
end
