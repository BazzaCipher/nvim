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
	keys = {
		{ "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Find Files" },
		{ "<leader>fg", function() require('telescope.builtin').live_grep() end, desc = "Find by Grep" },
		{ "<leader>fb", function() require('telescope.builtin').buffers() end, desc = "Find in Buffers" },
		{ "<leader>fh", function() require('telescope.builtin').help_tags() end, desc = "Find Help" },
	}
}
