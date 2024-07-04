-- Improved motion
return {
	'ggandor/leap.nvim',
	dependencies = {
		'tpope/vim-repeat'
	},
	init = function()
		vim.keymap.set('n', 's', '<Plug>(leap)')
		vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
	end
}
