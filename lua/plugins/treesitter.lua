return {
	"nvim-treesitter/nvim-treesitter",
	init = function()
		require('nvim-treesitter.configs').setup{ ensure_sync = true, auto_install = true }
	end,
}

