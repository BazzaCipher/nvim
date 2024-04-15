return {
	"jay-babu/mason-nvim-dap.nvim",
	
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonLog" },
	opts = {
		ensure_installed = {
			"cpptools",
			"codelldb",
		},
	}
}
