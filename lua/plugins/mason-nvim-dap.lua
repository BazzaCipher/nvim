return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = { " williamboman/mason.nvim" },
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonLog" },
	opts = {
		ensure_installed = {
			"cpptools",
			"codelldb",
		},
		automatic_setup = true,
	},
}
