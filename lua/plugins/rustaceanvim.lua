-- Rust tools on top of rust-analyzer tools for nvim
-- https://github.com/sharksforarms/neovim-rust/blob/master/neovim-init-lsp-cmp-rust-tools.lua
return {
	'mrcjkb/rustaceanvim',
	event = { "BufRead *.rs", "BufRead Cargo.*" },
	version = "^6",
	lazy = false,
}

