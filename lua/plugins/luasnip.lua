return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- Ensure jsregexp because why not
	init = function()
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
	build = 'make install_jsregexp',
	event = { "BufRead *.*" }
}
