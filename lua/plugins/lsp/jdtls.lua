return {
	"mfussenegger/nvim-jdtls",
	-- opts = function()
	-- 	return {
	-- 		cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
	-- 		root_dir = vim.fs.dirname(vim.fs.find({'gradlew', 'git', 'mvnw'}, { upward = true})[1]),
	-- 	}
	-- end,
	-- config = function(_,opts)
	-- 	return require('jdtls').start_or_attach(opts)
	-- end,
}
