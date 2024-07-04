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

	build = "make; :TSUpdate",
	config = function()
		require("telescope").load_extension("fzf")
	end,
	init = function()
		local builtin = require('telescope.builtin')
		local wk = require('which-key')
		wk.register({
			f = {
				name = '+file',
				f = { builtin.find_files, '[F]ind [F]iles' },
				g = { builtin.live_grep, '[F]ind by [G]rep' },
				b = { builtin.buffers, '[F]ind in [B]uffers' },
				h = { builtin.help_tags, '[F]ind [H]elp' },
			}
		}, { prefix = "<leader>"})
	end
}
