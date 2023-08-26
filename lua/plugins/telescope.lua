-- File finder and search functionality
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzf-native.nvim',
		'nvim-treesitter/nvim-treesitter',
		'nvim-treesitter/nvim-treesitter-textobjects',
		build = "make; :TSUpdate",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	init = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind in [B]uffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
	end
}
