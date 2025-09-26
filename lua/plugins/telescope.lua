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
		local wk = require('which-key')
		wk.add({
			{ '<leader>f', group = "File" },
			{ '<leader>ff', builtin.find_files, desc = '[F]ind [F]iles' },
			{ '<leader>fg', builtin.live_grep,  desc = '[F]ind by [G]rep' },
			{ '<leader>fb', builtin.buffers,    desc = '[F]ind in [B]uffers' },
			{ '<leader>fh', builtin.help_tags,  desc = '[F]ind [H]elp' },
		})
	end
}
