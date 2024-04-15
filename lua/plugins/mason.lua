return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonLog" },
	opts = {
		ensure_installed = {
			"cpptools",
			"codelldb",
		}
	},

	config = function()
		require('mason').setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})
	end
}
