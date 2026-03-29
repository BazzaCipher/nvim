-- File finder and search functionality
return {
	"nvim-telescope/telescope.nvim",
	lazy = false, -- Telescope is usually used immediately
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
		'nvim-treesitter/nvim-treesitter',
		'nvim-treesitter/nvim-treesitter-textobjects',
	},

	build = ":TSUpdate",
	config = function()
		require("telescope").load_extension("fzf")
	end,
	init = function()
		local builtin = require('telescope.builtin')
		require('which-key').add({
			{ "<leader>f", group = "file" },
			{ "<leader>ff", builtin.find_files, desc = "Find Files" },
			{ "<leader>fg", builtin.live_grep, desc = "Find by Grep" },
			{ "<leader>fb", builtin.buffers, desc = "Find in Buffers" },
			{ "<leader>fh", builtin.help_tags, desc = "Find Help" },
		})
	end
}
